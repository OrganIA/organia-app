import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:organia/src/data/repository.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();
  RegisterBloc() : super(const RegisterOnPage()) {
    on<RegisterClickOnRegisterEvent>(
        (event, emit) async => emit(await _registerRequest(event)));
    on<RegisterClickOnLoginEvent>(
        (event, emit) => emit(const RegisterNavigateToLogin()));
  }

  Future<RegisterState> _registerRequest(
      RegisterClickOnRegisterEvent event) async {
    try {
      await organIAAPIRepository.register(event.email, event.password);
      return const RegisterLoadedSuccess();
    } catch (e) {
      return RegisterLoadedFailure(e.toString());
    }
  }
}
