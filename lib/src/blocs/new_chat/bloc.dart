import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/data/repository.dart';
part 'event.dart';
part 'state.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  final OrganIAAPIRepository organIAAPIRepository = OrganIAAPIRepository();

  NewChatBloc() : super(const NewChatLoading()) {
    on<NewChatLoadEvent>((event, emit) async => emit(const NewChatLoaded()));
  }
}
