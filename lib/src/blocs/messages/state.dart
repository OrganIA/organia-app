part of 'bloc.dart';

abstract class ChatListState {
  const ChatListState();
}

class ChatListLoggedIn extends ChatListState {
  final String email;
  const ChatListLoggedIn(this.email);
}

class ChatListGuest extends ChatListState {
  const ChatListGuest();
}

class ChatListLoading extends ChatListState {
  const ChatListLoading();
}

class ChatListNavigate extends ChatListState {
  final String to;
  const ChatListNavigate(this.to);
}
