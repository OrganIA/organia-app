import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/utils/shared_preferences.dart';
part 'event.dart';
part 'state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountState initialState;
  AccountBloc([this.initialState = const AccountLoading()])
      : super(initialState) {
    on<AccountNavigateEvent>((event, emit) => emit(AccountNavigate(event.to)));
    on<AccountNavigationDoneEvent>((event, emit) => emit(const AccountGuest()));
    on<AccountLoginEvent>((event, emit) => emit(AccountLoggedIn(event.email)));
    on<AccountLogoutEvent>((event, emit) async => emit(await _logoutRequest()));
  }

  Future<AccountState> _logoutRequest() async {
    await MySharedPreferences().unset("AUTH");
    await MySharedPreferences().unset("USER_EMAIL");
    return const AccountGuest();
  }
}
