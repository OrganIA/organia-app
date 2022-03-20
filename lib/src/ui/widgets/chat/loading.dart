import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/chat/bloc.dart';
import 'package:organia/src/models/chat.dart';

class ChatLoadingPage extends StatefulWidget {
  final Chat chat;
  const ChatLoadingPage({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatLoadingPageState createState() => _ChatLoadingPageState();
}

class _ChatLoadingPageState extends State<ChatLoadingPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(ChatLoadEvent(widget.chat));
    return const CircularProgressIndicator();
  }
}