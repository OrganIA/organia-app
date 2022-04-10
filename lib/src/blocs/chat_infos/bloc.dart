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
  final Chat chat;
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();

  ChatInfosBloc({required this.initialState, required this.chat})
      : super(initialState) {
    on<ChatInfosNavigateEvent>((event, emit) => emit(ChatInfosNavigate(chat)));
    on<ChatInfosLoadEvent>(
        (event, emit) async => emit(await _getChatMessages(event.chat)));
    on<ChatInfosNavigationDoneEvent>(
        (event, emit) => emit(ChatInfosLoading(chat)));
  }

  Future<ChatInfosState> _getChatMessages(Chat chat) async {
    List<User> users = await organIAAPIRepository.getChatUsers(chat.usersIds);
    return ChatInfosLoaded(
      chat,
      hive.box.get("currentHiveUser").userId,
      users,
    );
  }
}
