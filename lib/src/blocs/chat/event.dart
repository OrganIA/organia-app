part of 'bloc.dart';

@immutable
abstract class ChatEvent {
  const ChatEvent();
}

class ChatNavigateEvent extends ChatEvent {
  const ChatNavigateEvent();
}

class ChatNavigationDoneEvent extends ChatEvent {
  const ChatNavigationDoneEvent();
}

class ChatLoadEvent extends ChatEvent {
  final Chat chat;
  const ChatLoadEvent(this.chat);
}
