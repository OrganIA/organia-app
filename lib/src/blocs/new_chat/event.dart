part of 'bloc.dart';

@immutable
abstract class NewChatEvent {
  const NewChatEvent();
}

class NewChatNavigateEvent extends NewChatEvent {
  final String to;
  const NewChatNavigateEvent(this.to);
}

class NewChatNavigationDoneEvent extends NewChatEvent {
  const NewChatNavigationDoneEvent();
}

class NewChatLoadEvent extends NewChatEvent {
  final Chat chat;
  const NewChatLoadEvent(this.chat);
}
