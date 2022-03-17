import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/shared_preferences.dart';
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
      MySharedPreferences().unset("USER_ID");
      MySharedPreferences().unset("TOKEN");
      return const AccountGuest();
    }
  }

  Future<AccountState> logoutRequest() async {
    await MySharedPreferences().unset("USER_ID");
    await MySharedPreferences().unset("TOKEN");
    return const AccountGuest();
  }
}
