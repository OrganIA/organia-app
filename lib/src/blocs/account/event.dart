part of 'bloc.dart';

@immutable
abstract class AccountEvent {
  const AccountEvent();
}

class AccountNavigateEvent extends AccountEvent {
  final String to;
  const AccountNavigateEvent(this.to);
}

class AccountNavigationDoneEvent extends AccountEvent {
  const AccountNavigationDoneEvent();
}

class AccountLoginEvent extends AccountEvent {
  final String email;
  const AccountLoginEvent(this.email);
}

class AccountAutoLoginEvent extends AccountEvent {
  final String token;
  const AccountAutoLoginEvent(this.token);
}

class AccountLogoutEvent extends AccountEvent {
  const AccountLogoutEvent();
}
