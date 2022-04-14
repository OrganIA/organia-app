import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/myhive.dart';
part 'event.dart';
part 'state.dart';

class ChatInfosBloc extends Bloc<ChatInfosEvent, ChatInfosState> {
  final ChatInfosState initialState;
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();

  ChatInfosBloc({required this.initialState}) : super(initialState) {
    on<ChatInfosNavigateEvent>(
        (event, emit) => emit(ChatInfosNavigate(event.chatId)));
    on<ChatInfosLoadEvent>(
        (event, emit) async => emit(await _getChatMessages(event.chatId)));
    on<ChatInfosNavigationDoneEvent>(
        (event, emit) => emit(ChatInfosLoading(event.chatId)));
  }

  Future<ChatInfosState> _getChatMessages(int chatId) async {
    Chat chat = await organIAAPIRepository.getChat(chatId);
    List<User> users = await organIAAPIRepository.getChatUsers(chat.usersIds);
    return ChatInfosLoaded(
      chat,
      hive.box.get("currentHiveUser").userId,
      users,
    );
  }
}
