part of 'bloc.dart';

abstract class ChatsListState {
  const ChatsListState();
}

class ChatsListLoggedIn extends ChatsListState {
  final List<Chat> chats;
  const ChatsListLoggedIn(this.chats);
}

class ChatsListGuest extends ChatsListState {
  const ChatsListGuest();
}

class ChatsListLoading extends ChatsListState {
  const ChatsListLoading();
}

class ChatsListNavigate extends ChatsListState {
  final String to;
  const ChatsListNavigate(this.to);
}
