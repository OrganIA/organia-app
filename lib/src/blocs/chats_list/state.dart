part of 'bloc.dart';

abstract class ChatsListState {
  const ChatsListState();
}

class ChatsListLoggedIn extends ChatsListState {
  final String email;
  const ChatsListLoggedIn(this.email);
}

class ChatsListGuest extends ChatsListState {
  const ChatsListGuest();
}

class ChatsListLoading extends ChatsListState {
  const ChatsListLoading();
}

class ChatsListNavigate extends ChatsListState {
  final String to;
  const ChatsListNavigate(this.to);
}
