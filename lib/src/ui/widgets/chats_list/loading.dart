import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/chats_list/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/utils/myhive.dart';

class ChatsListLoadingPage extends StatefulWidget {
  const ChatsListLoadingPage({Key? key}) : super(key: key);

  @override
  _ChatsListLoadingPageState createState() => _ChatsListLoadingPageState();
}

class _ChatsListLoadingPageState extends State<ChatsListLoadingPage> {
  @override
  Widget build(BuildContext context) {
    if (hive.box.containsKey("currentHiveUser")) {
      BlocProvider.of<ChatsListBloc>(context).add(const ChatsListLoadEvent());
    } else {
      BlocProvider.of<ChatsListBloc>(context).add(const ChatsListGuestEvent());
    }
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(color: darkBlue),
      ),
    );
  }
}
