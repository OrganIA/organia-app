import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/chat/bloc.dart';
import 'package:organia/src/blocs/chat_infos/bloc.dart';
import 'package:organia/src/ui/screens/chat_infos.dart';
import 'package:organia/src/ui/widgets/chat/loaded.dart';
import 'package:organia/src/ui/widgets/chat/loading.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) async {
        if (state is ChatNavigate) {
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => ChatInfosBloc(
                  initialState: ChatInfosLoading(state.chat),
                  chat: state.chat,
                ),
                child: const ChatInfosScreen(),
              ),
            ),
          );
          BlocProvider.of<ChatBloc>(context)
              .add(const ChatNavigationDoneEvent());
        }
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (ChatState previous, ChatState current) {
          return (true);
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return (ChatLoadingPage(chat: state.chat));
          } else if (state is ChatLoaded) {
            return (ChatLoadedPage(
              messages: state.messages,
              chat: state.chat,
              userId: state.userId,
              users: state.users,
            ));
          } else {
            return (Container());
          }
        },
      ),
    );
  }
}
