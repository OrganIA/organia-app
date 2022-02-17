import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/models/chat.dart';
// import 'package:organia/src/utils/shared_preferences.dart';
part 'event.dart';
part 'state.dart';

class ChatsListBloc extends Bloc<ChatsListEvent, ChatsListState> {
  final ChatsListState initialState;
  ChatsListBloc([this.initialState = const ChatsListLoading()])
      : super(initialState) {
    on<ChatsListNavigateEvent>(
        (event, emit) => emit(ChatsListNavigate(event.to)));
    on<ChatsListNavigationDoneEvent>(
        (event, emit) => emit(const ChatsListGuest()));
    on<ChatsListLoadEvent>((event, emit) async => emit(await _getUserChats()));
    on<ChatsListGuestEvent>((event, emit) => emit(const ChatsListGuest()));
  }

  Future<ChatsListState> _getUserChats() async {
    return const ChatsListLoggedIn([]);
  }
}
