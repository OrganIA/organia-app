import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/myhive.dart';
part 'event.dart';
part 'state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();
  final AccountState initialState;
  AccountBloc([this.initialState = const AccountLoading()])
      : super(initialState) {
    on<AccountNavigateEvent>((event, emit) => emit(AccountNavigate(event.to)));
    on<AccountNavigationDoneEvent>((event, emit) => emit(const AccountGuest()));
    on<AccountLoginEvent>((event, emit) => emit(AccountLoggedIn(event.email)));
    on<AccountAutoLoginEvent>(
        (event, emit) async => emit(await autoLogin(event)));
    on<AccountLogoutEvent>((event, emit) async => emit(await logoutRequest()));
  }

  Future<AccountState> autoLogin(AccountAutoLoginEvent event) async {
    try {
      final User user = await organIAAPIRepository.geMyInfos(event.token);
      return AccountLoggedIn(user.email);
    } catch (e) {
      await hive.box.delete("currentHiveUser");
      return const AccountGuest();
    }
  }

  Future<AccountState> logoutRequest() async {
    await hive.box.delete("currentHiveUser");
    return const AccountGuest();
  }
}
