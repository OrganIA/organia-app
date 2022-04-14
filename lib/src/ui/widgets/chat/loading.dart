import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/chat/bloc.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/ui/themes/themes.dart';

class ChatLoadingPage extends StatefulWidget {
  final int chatId;
  const ChatLoadingPage({Key? key, required this.chatId}) : super(key: key);

  @override
  _ChatLoadingPageState createState() => _ChatLoadingPageState();
}

class _ChatLoadingPageState extends State<ChatLoadingPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(ChatLoadEvent(widget.chatId));
    return Center(
      child: CircularProgressIndicator(color: blue),
    );
  }
}
