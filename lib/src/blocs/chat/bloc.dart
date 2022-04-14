import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/myhive.dart';
part 'event.dart';
part 'state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatState initialState;
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();

  ChatBloc(this.initialState) : super(initialState) {
    on<ChatNavigateEvent>((event, emit) => emit(ChatNavigate(event.chatId)));
    on<ChatLoadEvent>(
        (event, emit) async => emit(await _getChatMessages(event.chatId)));
    on<ChatNavigationDoneEvent>(
        (event, emit) => emit(ChatLoading(event.chatId)));
  }

  Future<ChatState> _getChatMessages(int chatId) async {
    Chat chat = await organIAAPIRepository.getChat(chatId);
    List<Message> messagesList =
        await organIAAPIRepository.getChatMessages(chat.chatId);
    List<User> users = await organIAAPIRepository.getAllUsers();
    return ChatLoaded(
      messagesList,
      chat,
      hive.box.get("currentHiveUser").userId,
      users,
    );
  }
}
