part of 'bloc.dart';

@immutable
abstract class EditChatEvent {
  const EditChatEvent();
}

class EditChatLoadEvent extends EditChatEvent {
  final int chatId;
  const EditChatLoadEvent(this.chatId);
}

class EditChatEditEvent extends EditChatEvent {
  final String chatName;
  final List<User> users;
  final int chatId;
  const EditChatEditEvent(this.chatName, this.users, this.chatId);
}

class EditChatDeleteEvent extends EditChatEvent {
  final int chatId;
  const EditChatDeleteEvent(this.chatId);
}
