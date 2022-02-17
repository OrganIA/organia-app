part of 'bloc.dart';

@immutable
abstract class ChatsListEvent {
  const ChatsListEvent();
}

class ChatsListNavigateEvent extends ChatsListEvent {
  final String to;
  const ChatsListNavigateEvent(this.to);
}

class ChatsListNavigationDoneEvent extends ChatsListEvent {
  const ChatsListNavigationDoneEvent();
}

class ChatsListLoadEvent extends ChatsListEvent {
  const ChatsListLoadEvent();
}

class ChatsListGuestEvent extends ChatsListEvent {
  const ChatsListGuestEvent();
}
