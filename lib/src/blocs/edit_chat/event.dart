part of 'bloc.dart';

@immutable
abstract class EditChatEvent {
  const EditChatEvent();
}

class EditChatLoadEvent extends EditChatEvent {
  final Chat chat;
  const EditChatLoadEvent(this.chat);
}

class EditChatCreateEvent extends EditChatEvent {
  final String chatName;
  final List<User> users;
  const EditChatCreateEvent(this.chatName, this.users);
}
