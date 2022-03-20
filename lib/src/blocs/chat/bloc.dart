import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/utils/shared_preferences.dart';
part 'event.dart';
part 'state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatState initialState;
  final Chat chat;
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();

  ChatBloc(this.initialState, this.chat) : super(initialState) {
    on<ChatNavigateEvent>((event, emit) => emit(ChatNavigate(chat)));
    on<ChatLoadEvent>(
        (event, emit) async => emit(await _getChatMessages(event.chat.chatId)));
    on<ChatNavigationDoneEvent>((event, emit) => emit(ChatLoading(chat)));
  }

  Future<ChatState> _getChatMessages(int id) async {
    String token = await MySharedPreferences().get("TOKEN");
    List<Message> messagesList =
        await organIAAPIRepository.getChatMessages(token, id);
    return ChatLoaded(messagesList, chat,
        int.parse(await MySharedPreferences().get("USER_ID")));
  }
}