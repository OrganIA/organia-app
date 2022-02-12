import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/user.dart';

part 'event.dart';
part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();
  LoginBloc() : super(const LoginOnPage()) {
    on<LoginClickOnLoginEvent>(
        (event, emit) async => emit(await _loginRequest(event)));
  }

  Future<LoginState> _loginRequest(LoginClickOnLoginEvent event) async {
    try {
      final User user =
          await organIAAPIRepository.login(event.email, event.password);
      return LoginLoadedSuccess(user.email);
    } catch (e) {
      return LoginLoadedFailure(e.toString());
    }
  }
}
