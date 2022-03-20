import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/chats_list/bloc.dart';
import 'package:organia/src/utils/shared_preferences.dart';

class ChatsListLoadingPage extends StatefulWidget {
  const ChatsListLoadingPage({Key? key}) : super(key: key);

  @override
  _ChatsListLoadingPageState createState() => _ChatsListLoadingPageState();
}

class _ChatsListLoadingPageState extends State<ChatsListLoadingPage> {
  @override
  Widget build(BuildContext context) {
    MySharedPreferences().get("TOKEN").then((token) {
      if (token != null && token.isNotEmpty) {
        BlocProvider.of<ChatsListBloc>(context).add(const ChatsListLoadEvent());
      } else {
        BlocProvider.of<ChatsListBloc>(context)
            .add(const ChatsListGuestEvent());
      }
    });
    return const CircularProgressIndicator();
  }
}
