part of 'bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoadedSuccess extends LoginState {
  String email;
  LoginLoadedSuccess(this.email);
}

class LoginLoadedFailure extends LoginState {
  String cause = "";

  LoginLoadedFailure(this.cause);
}

class LoginOnPage extends LoginState {
  const LoginOnPage();
}
