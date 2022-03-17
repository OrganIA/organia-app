part of 'bloc.dart';

abstract class ChatState {
  const ChatState();
}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  final Chat chat;
  final int userId;
  const ChatLoaded(this.messages, this.chat, this.userId);
}

class ChatError extends ChatState {
  final String cause;
  const ChatError(this.cause);
}

class ChatLoading extends ChatState {
  final Chat chat;
  const ChatLoading(this.chat);
}

class ChatNavigate extends ChatState {
  final Chat chat;
  const ChatNavigate(this.chat);
}
