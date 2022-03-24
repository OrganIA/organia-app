part of 'bloc.dart';

@immutable
abstract class NewChatEvent {
  const NewChatEvent();
}

class NewChatLoadEvent extends NewChatEvent {
  const NewChatLoadEvent();
}

class NewChatReloadEvent extends NewChatEvent {
  const NewChatReloadEvent();
}
