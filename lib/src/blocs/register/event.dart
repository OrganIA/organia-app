part of 'bloc.dart';

@immutable
abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterClickOnRegisterEvent extends RegisterEvent {
  final String email;
  final String password;
  final String firstname;
  final String lastname;
  final String phone;
  final String countryCode;

  const RegisterClickOnRegisterEvent(
    this.email,
    this.password,
    this.firstname,
    this.lastname,
    this.phone,
    this.countryCode,
  );
}

class RegisterClickOnLoginEvent extends RegisterEvent {
  const RegisterClickOnLoginEvent();
}
