part of 'bloc.dart';

@immutable
abstract class ChatEvent {
  const ChatEvent();
}

class ChatNavigateEvent extends ChatEvent {
  final int chatId;
  const ChatNavigateEvent(this.chatId);
}

class ChatNavigationDoneEvent extends ChatEvent {
  final int chatId;
  const ChatNavigationDoneEvent(this.chatId);
}

class ChatLoadEvent extends ChatEvent {
  final int chatId;
  const ChatLoadEvent(this.chatId);
}
