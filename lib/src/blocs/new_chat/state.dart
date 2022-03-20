part of 'bloc.dart';

abstract class NewChatState {
  const NewChatState();
}

class NewChatLoaded extends NewChatState {
  final List<Message> messages;
  final Chat chat;
  final int userId;
  const NewChatLoaded(this.messages, this.chat, this.userId);
}

class NewChatError extends NewChatState {
  final String cause;
  const NewChatError(this.cause);
}

class NewChatLoading extends NewChatState {
  final Chat chat;
  const NewChatLoading(this.chat);
}

class NewChatNavigate extends NewChatState {
  final Chat chat;
  final String to;
  const NewChatNavigate(this.chat, this.to);
}
