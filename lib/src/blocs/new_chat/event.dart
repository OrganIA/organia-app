part of 'bloc.dart';

@immutable
abstract class NewChatEvent {
  const NewChatEvent();
}

class NewChatNavigateEvent extends NewChatEvent {
  const NewChatNavigateEvent();
}

class NewChatNavigationDoneEvent extends NewChatEvent {
  const NewChatNavigationDoneEvent();
}

class NewChatLoadEvent extends NewChatEvent {
  const NewChatLoadEvent();
}

class NewChatReloadEvent extends NewChatEvent {
  const NewChatReloadEvent();
}
