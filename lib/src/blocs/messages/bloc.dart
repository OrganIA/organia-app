import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:organia/src/utils/shared_preferences.dart';
part 'event.dart';
part 'state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatListState initialState;
  ChatListBloc([this.initialState = const ChatListLoading()])
      : super(initialState) {
    on<ChatListNavigateEvent>(
        (event, emit) => emit(ChatListNavigate(event.to)));
    on<ChatListNavigationDoneEvent>(
        (event, emit) => emit(const ChatListGuest()));
  }
}
