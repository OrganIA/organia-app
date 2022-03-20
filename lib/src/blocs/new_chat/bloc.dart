import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/utils/shared_preferences.dart';
part 'event.dart';
part 'state.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  final NewChatState initialState;
  final Chat chat;
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();

  NewChatBloc(this.initialState, this.chat) : super(initialState) {
    on<NewChatNavigateEvent>(
        (event, emit) => emit(NewChatNavigate(chat, event.to)));
    on<NewChatLoadEvent>((event, emit) async =>
        emit(await _getNewChatMessages(event.chat.chatId)));
    on<NewChatNavigationDoneEvent>((event, emit) => emit(NewChatLoading(chat)));
  }

  Future<NewChatState> _getNewChatMessages(int id) async {
    String token = await MySharedPreferences().get("TOKEN");
    List<Message> messagesList =
        await organIAAPIRepository.getChatMessages(token, id);
    return NewChatLoaded(messagesList, chat,
        int.parse(await MySharedPreferences().get("USER_ID")));
  }
}
