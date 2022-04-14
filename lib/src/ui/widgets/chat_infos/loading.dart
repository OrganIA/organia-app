import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/chat_infos/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';

class ChatInfosLoadingPage extends StatefulWidget {
  final int chatId;
  const ChatInfosLoadingPage({Key? key, required this.chatId})
      : super(key: key);

  @override
  _ChatInfosLoadingPageState createState() => _ChatInfosLoadingPageState();
}

class _ChatInfosLoadingPageState extends State<ChatInfosLoadingPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatInfosBloc>(context)
        .add(ChatInfosLoadEvent(widget.chatId));
    return Center(
      child: CircularProgressIndicator(color: blue),
    );
  }
}
