import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/myhive.dart';
import 'package:collection/collection.dart';
part 'event.dart';
part 'state.dart';

class EditChatBloc extends Bloc<EditChatEvent, EditChatState> {
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();
  final EditChatState initialState;
  EditChatBloc({required this.initialState}) : super(initialState) {
    on<EditChatLoadEvent>(
        (event, emit) async => emit(await getAllUsers(event)));
    on<EditChatEditEvent>((event, emit) async => emit(await editChat(event)));
    on<EditChatDeleteEvent>(
        (event, emit) async => emit(await deleteChat(event)));
  }

  Future<EditChatState> getAllUsers(EditChatLoadEvent event) async {
    Chat chat = await organIAAPIRepository.getChat(event.chatId);
    final List<User> chatUsers = chat.users;
    List<User> users = await organIAAPIRepository.getAllUsers();
    users.removeWhere((user) {
      if (chatUsers.firstWhereOrNull((element) => element.id == user.id) !=
          null) {
        return true;
      } else {
        return false;
      }
    });
    chatUsers.removeWhere(
      (element) => element.id == hive.box.get("currentHiveUser").userId,
    );
    return EditChatLoaded(users, chat, chatUsers);
  }

  Future<EditChatState> editChat(EditChatEditEvent event) async {
    try {
      await organIAAPIRepository.editChat(
        event.chatName,
        event.users,
        event.chatId,
      );
      return const EditChatDone();
    } catch (e) {
      return EditChatError(e.toString());
    }
  }

  Future<EditChatState> deleteChat(EditChatDeleteEvent event) async {
    try {
      await organIAAPIRepository.deleteChat(
        event.chatId,
      );
      return const EditChatDeleteDone();
    } catch (e) {
      return EditChatError(e.toString());
    }
  }
}
