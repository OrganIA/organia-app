import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/edit_chat/bloc.dart';
import 'package:organia/src/ui/widgets/edit_chat/loaded.dart';
import 'package:organia/src/ui/widgets/edit_chat/loading.dart';

class EditChatScreen extends StatefulWidget {
  const EditChatScreen({Key? key}) : super(key: key);

  @override
  _EditChatScreenState createState() => _EditChatScreenState();
}

class _EditChatScreenState extends State<EditChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<EditChatBloc, EditChatState>(
      listener: (context, state) async {
        if (state is EditChatDone) {
          Navigator.pop(context, false);
        } else if (state is EditChatDeleteDone) {
          Navigator.pop(context, "deleted");
        }
      },
      child: BlocBuilder<EditChatBloc, EditChatState>(
          buildWhen: (EditChatState previous, EditChatState current) {
        return (true);
      }, builder: (context, state) {
        if (state is EditChatLoading) {
          return (EditChatLoadingPage(
            chatId: state.chatId,
          ));
        } else if (state is EditChatLoaded) {
          return (EditChatLoadedPage(
            users: state.users,
            chat: state.chat,
            chatUsers: state.chatUsers,
          ));
        } else if (state is EditChatLoaded) {
          return (EditChatLoadedPage(
            users: state.users,
            chat: state.chat,
            chatUsers: state.chatUsers,
          ));
        } else {
          return (Container());
        }
      }),
    );
  }
}
