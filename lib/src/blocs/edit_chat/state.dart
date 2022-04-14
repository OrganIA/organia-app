part of 'bloc.dart';

abstract class EditChatState {
  const EditChatState();
}

class EditChatLoaded extends EditChatState {
  final List<User> users;
  final List<User> chatUsers;
  final Chat chat;
  const EditChatLoaded(this.users, this.chat, this.chatUsers);
}

class EditChatLoading extends EditChatState {
  final Chat chat;
  const EditChatLoading(this.chat);
}

class EditChatDone extends EditChatState {
  const EditChatDone();
}

class EditChatError extends EditChatState {
  final String cause;
  const EditChatError(this.cause);
}

class EditChatNavigate extends EditChatState {
  const EditChatNavigate();
}
