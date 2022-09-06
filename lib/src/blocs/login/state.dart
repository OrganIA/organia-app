part of 'bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginNavigateToRegister extends LoginState {
  const LoginNavigateToRegister();
}

class LoginLoadedSuccess extends LoginState {
  String email;
  String firstName;
  String lastName;
  LoginLoadedSuccess(this.email, this.firstName, this.lastName);
}

class LoginLoadedFailure extends LoginState {
  String cause = "";

  LoginLoadedFailure(this.cause);
}

class LoginOnPage extends LoginState {
  const LoginOnPage();
}
