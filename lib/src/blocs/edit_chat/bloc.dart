import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/myhive.dart';
part 'event.dart';
part 'state.dart';

class EditChatBloc extends Bloc<EditChatEvent, EditChatState> {
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();
  final EditChatState initialState;
  EditChatBloc({required this.initialState}) : super(initialState) {
    on<EditChatLoadEvent>(
        (event, emit) async => emit(await getAllUsers(event)));
    on<EditChatCreateEvent>(
        (event, emit) async => emit(await createChat(event)));
  }

  Future<EditChatState> getAllUsers(EditChatLoadEvent event) async {
    final List<User> chatUsers =
        await organIAAPIRepository.getChatUsers(event.chat.usersIds);
    List<User> users = await organIAAPIRepository.getAllUsers();
    for (var user in users) {
      if (chatUsers.contains(user)) {
        users.remove(user);
      }
    }
    chatUsers.removeWhere(
      (element) => element.id == hive.box.get("currentHiveUser").userId,
    );
    return EditChatLoaded(users, event.chat, chatUsers);
  }

  Future<EditChatState> createChat(EditChatCreateEvent event) async {
    try {
      await organIAAPIRepository.createChat(event.chatName, event.users);
      return const EditChatDone();
    } catch (e) {
      return EditChatError(e.toString());
    }
  }
}
