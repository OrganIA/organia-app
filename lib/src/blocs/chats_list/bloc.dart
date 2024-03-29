import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
import 'package:organia/src/models/chat.dart';
part 'event.dart';
part 'state.dart';

class ChatsListBloc extends Bloc<ChatsListEvent, ChatsListState> {
  final ChatsListState initialState;
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();
  ChatsListBloc([this.initialState = const ChatsListLoading()])
      : super(initialState) {
    on<ChatsListNavigateEvent>(
        (event, emit) => emit(ChatsListNavigate(event.to, event.chat)));
    on<ChatsListNavigationDoneEvent>(
        (event, emit) => emit(const ChatsListLoading()));
    on<ChatsListLoadEvent>((event, emit) async => emit(await _getChats()));
    on<ChatsListReLoadEvent>(
        (event, emit) async => emit(const ChatsListLoading()));
    on<ChatsListGuestEvent>((event, emit) => emit(const ChatsListGuest()));
  }

  Future<ChatsListState> _getChats() async {
    try {
      List<Chat> chatsList = await organIAAPIRepository.getChats();
      return ChatsListLoggedIn(chatsList);
    } catch (e) {
      return const ChatsListGuest();
    }
  }
}
