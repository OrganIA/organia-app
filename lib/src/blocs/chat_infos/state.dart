part of 'bloc.dart';

abstract class ChatInfosState {
  const ChatInfosState();
}

class ChatInfosLoaded extends ChatInfosState {
  final Chat chat;
  final int userId;
  final List<User> users;
  const ChatInfosLoaded(this.chat, this.userId, this.users);
}

class ChatInfosError extends ChatInfosState {
  final String cause;
  const ChatInfosError(this.cause);
}

class ChatInfosLoading extends ChatInfosState {
  final Chat chat;
  const ChatInfosLoading(this.chat);
}

class ChatInfosNavigate extends ChatInfosState {
  final Chat chat;
  const ChatInfosNavigate(this.chat);
}
