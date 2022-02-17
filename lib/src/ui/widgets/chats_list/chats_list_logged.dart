import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/chats_list/bloc.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/big_button.dart';

class ChatsListLoggedInPage extends StatefulWidget {
  final List<Chat> chats;

  const ChatsListLoggedInPage({Key? key, required this.chats})
      : super(key: key);

  @override
  _ChatsListLoggedInPageState createState() => _ChatsListLoggedInPageState();
}

class _ChatsListLoggedInPageState extends State<ChatsListLoggedInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
        child: Column(),
      ),
    );
  }
}
