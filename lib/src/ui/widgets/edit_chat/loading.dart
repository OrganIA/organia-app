import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/edit_chat/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';

class EditChatLoadingPage extends StatefulWidget {
  final int chatId;
  const EditChatLoadingPage({Key? key, required this.chatId}) : super(key: key);

  @override
  _EditChatLoadingPageState createState() => _EditChatLoadingPageState();
}

class _EditChatLoadingPageState extends State<EditChatLoadingPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EditChatBloc>(context)
        .add(EditChatLoadEvent(widget.chatId));
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(color: blue),
        ),
      ),
    );
  }
}
