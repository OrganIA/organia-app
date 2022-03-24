import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/myhive.dart';
part 'event.dart';
part 'state.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();

  NewChatBloc() : super(const NewChatLoading()) {
    on<NewChatLoadEvent>((event, emit) async => emit(await getAllUsers()));
    on<NewChatCreateEvent>(
        (event, emit) async => emit(await createChat(event)));
  }

  Future<NewChatState> getAllUsers() async {
    List<User> users = await organIAAPIRepository.getAllUsers();
    users.removeWhere(
      (element) => element.id == hive.box.get("currentHiveUser").userId,
    );
    return NewChatLoaded(users);
  }

  Future<NewChatState> createChat(NewChatCreateEvent event) async {
    try {
      await organIAAPIRepository.createChat(event.chatName, event.users);
      return const NewChatDone();
    } catch (e) {
      return NewChatError(e.toString());
    }
  }
}
