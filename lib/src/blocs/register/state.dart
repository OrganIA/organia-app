part of 'bloc.dart';

abstract class RegisterState {
  const RegisterState();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterNavigateToLogin extends RegisterState {
  const RegisterNavigateToLogin();
}

class RegisterLoadedSuccess extends RegisterState {
  const RegisterLoadedSuccess();
}

class RegisterLoadedFailure extends RegisterState {
  String cause = "";

  RegisterLoadedFailure(this.cause);
}

class RegisterOnPage extends RegisterState {
  const RegisterOnPage();
}
