part of 'bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class LoginClickOnLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginClickOnLoginEvent(this.email, this.password);
}
