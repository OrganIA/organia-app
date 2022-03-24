import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/new_chat/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/new_chat/loaded.dart';
import 'package:organia/src/ui/widgets/new_chat/loading.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({Key? key}) : super(key: key);

  @override
  _NewChatScreenState createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NewChatBloc, NewChatState>(
      listener: (context, state) async {
        if (state is NewChatDone) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<NewChatBloc, NewChatState>(
          buildWhen: (NewChatState previous, NewChatState current) {
        return (true);
      }, builder: (context, state) {
        if (state is NewChatLoading) {
          return (const NewChatLoadingPage());
        } else if (state is NewChatLoaded) {
          return (NewChatLoadedPage(users: state.users));
        } else {
          return (Container());
        }
      }),
    );
  }
}
