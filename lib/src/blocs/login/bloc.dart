import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
// import 'package:organia/src/utils/shared_preferences.dart';

part 'event.dart';
part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginOnPage()) {
    on<LoginClickOnLoginEvent>(
        (event, emit) async => emit(await _loginRequest(event)));
  }

  Future<LoginState> _loginRequest(LoginClickOnLoginEvent event) async {
    try {
      // print("login");
      return LoginLoadedSuccess("saber@saber.com");
    } catch (e) {
      return LoginLoadedFailure(e.toString());
    }
  }
}
