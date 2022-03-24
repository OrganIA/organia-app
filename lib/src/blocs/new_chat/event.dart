part of 'bloc.dart';

@immutable
abstract class NewChatEvent {
  const NewChatEvent();
}

class NewChatLoadEvent extends NewChatEvent {
  const NewChatLoadEvent();
}

class NewChatCreateEvent extends NewChatEvent {
  final String chatName;
  final List<User> users;
  const NewChatCreateEvent(this.chatName, this.users);
}
