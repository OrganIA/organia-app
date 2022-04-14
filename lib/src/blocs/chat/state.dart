part of 'bloc.dart';

abstract class ChatState {
  const ChatState();
}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  final Chat chat;
  final int userId;
  final List<User> users;
  const ChatLoaded(this.messages, this.chat, this.userId, this.users);
}

class ChatError extends ChatState {
  final String cause;
  const ChatError(this.cause);
}

class ChatLoading extends ChatState {
  final int chatId;
  const ChatLoading(this.chatId);
}

class ChatNavigate extends ChatState {
  final int chatId;
  const ChatNavigate(this.chatId);
}
