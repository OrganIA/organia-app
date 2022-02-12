part of 'bloc.dart';

@immutable
abstract class ChatListEvent {
  const ChatListEvent();
}

class ChatListNavigateEvent extends ChatListEvent {
  final String to;
  const ChatListNavigateEvent(this.to);
}

class ChatListNavigationDoneEvent extends ChatListEvent {
  const ChatListNavigationDoneEvent();
}
