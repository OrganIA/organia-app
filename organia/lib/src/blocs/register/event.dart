part of 'bloc.dart';

@immutable
abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterClickOnRegisterEvent extends RegisterEvent {
  final String email;
  final String password;

  const RegisterClickOnRegisterEvent(this.email, this.password);
}
