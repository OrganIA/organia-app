part of 'bloc.dart';

abstract class NewChatState {
  const NewChatState();
}

class NewChatLoaded extends NewChatState {
  const NewChatLoaded();
}

class NewChatLoading extends NewChatState {
  const NewChatLoading();
}

class NewChatError extends NewChatState {
  final String cause;
  const NewChatError(this.cause);
}

class NewChatNavigate extends NewChatState {
  const NewChatNavigate();
}
