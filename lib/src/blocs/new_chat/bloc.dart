import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/user.dart';
part 'event.dart';
part 'state.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();

  NewChatBloc() : super(const NewChatLoading()) {
    on<NewChatLoadEvent>((event, emit) async => emit(await getAllUsers()));
  }

  Future<NewChatState> getAllUsers() async {
    List<User> users = await organIAAPIRepository.getAllUsers();
    return NewChatLoaded(users);
  }
}
