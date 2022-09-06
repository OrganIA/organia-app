part of 'bloc.dart';

abstract class AccountState {
  const AccountState();
}

class AccountLoggedIn extends AccountState {
  final String email;
  final String firstName;
  final String lastName;
  const AccountLoggedIn(this.email, this.firstName, this.lastName);
}

class AccountGuest extends AccountState {
  const AccountGuest();
}

class AccountLoading extends AccountState {
  const AccountLoading();
}

class AccountNavigate extends AccountState {
  final String to;
  const AccountNavigate(this.to);
}
