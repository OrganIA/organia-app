import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterOnPage()) {
    on<RegisterClickOnRegisterEvent>(
        (event, emit) async => emit(await _registerRequest(event)));
  }

  Future<RegisterState> _registerRequest(
      RegisterClickOnRegisterEvent event) async {
    try {
      // print("register");
      return const RegisterLoadedSuccess();
    } catch (e) {
      return RegisterLoadedFailure(e.toString());
    }
  }
}
