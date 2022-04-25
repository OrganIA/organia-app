import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/new_chat/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';

class NewChatLoadingPage extends StatefulWidget {
  const NewChatLoadingPage({Key? key}) : super(key: key);

  @override
  _NewChatLoadingPageState createState() => _NewChatLoadingPageState();
}

class _NewChatLoadingPageState extends State<NewChatLoadingPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewChatBloc>(context).add(const NewChatLoadEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(color: blue),
        ),
      ),
    );
  }
}
