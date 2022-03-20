import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
part 'event.dart';
part 'state.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();

  NewChatBloc() : super(const NewChatLoading()) {
    on<NewChatNavigateEvent>((event, emit) => emit(const NewChatNavigate()));
    on<NewChatLoadEvent>((event, emit) async => emit(const NewChatLoaded(1)));
    on<NewChatNavigationDoneEvent>(
        (event, emit) => emit(const NewChatLoading()));
  }

  // Future<NewChatState> _getNewChatMessages(int id) async {
  //   String token = await MySharedPreferences().get("TOKEN");
  //   List<Message> messagesList =
  //       await organIAAPIRepository.getChatMessages(token, id);
  //   return NewChatLoaded(messagesList, chat,
  //       int.parse(await MySharedPreferences().get("USER_ID")));
  // }
}
