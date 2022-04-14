part of 'bloc.dart';

@immutable
abstract class ChatInfosEvent {
  const ChatInfosEvent();
}

class ChatInfosNavigateEvent extends ChatInfosEvent {
  final int chatId;
  const ChatInfosNavigateEvent(this.chatId);
}

class ChatInfosNavigationDoneEvent extends ChatInfosEvent {
  final int chatId;
  const ChatInfosNavigationDoneEvent(this.chatId);
}

class ChatInfosLoadEvent extends ChatInfosEvent {
  final int chatId;
  const ChatInfosLoadEvent(this.chatId);
}
