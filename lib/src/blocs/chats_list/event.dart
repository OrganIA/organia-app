part of 'bloc.dart';

@immutable
abstract class ChatsListEvent {
  const ChatsListEvent();
}

class ChatsListNavigateEvent extends ChatsListEvent {
  final Destination to;
  final Chat? chat;
  const ChatsListNavigateEvent(this.to, this.chat);
}

class ChatsListNavigationDoneEvent extends ChatsListEvent {
  const ChatsListNavigationDoneEvent();
}

class ChatsListLoadEvent extends ChatsListEvent {
  const ChatsListLoadEvent();
}

class ChatsListReLoadEvent extends ChatsListEvent {
  const ChatsListReLoadEvent();
}

class ChatsListGuestEvent extends ChatsListEvent {
  const ChatsListGuestEvent();
}
