part of 'bloc.dart';

@immutable
abstract class ChatInfosEvent {
  const ChatInfosEvent();
}

class ChatInfosNavigateEvent extends ChatInfosEvent {
  const ChatInfosNavigateEvent();
}

class ChatInfosNavigationDoneEvent extends ChatInfosEvent {
  const ChatInfosNavigationDoneEvent();
}

class ChatInfosLoadEvent extends ChatInfosEvent {
  final Chat chat;
  const ChatInfosLoadEvent(this.chat);
}
