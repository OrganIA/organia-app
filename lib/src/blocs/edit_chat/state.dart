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
  final int chatId;
  const EditChatLoading(this.chatId);
}

class EditChatDone extends EditChatState {
  const EditChatDone();
}

class EditChatDeleteDone extends EditChatState {
  const EditChatDeleteDone();
}

class EditChatError extends EditChatState {
  final String cause;
  const EditChatError(this.cause);
}
