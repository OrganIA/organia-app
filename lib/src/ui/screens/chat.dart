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
          var result = await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => BlocProvider(
                create: (_) =>
                    ChatInfosBloc(initialState: ChatInfosLoading(state.chatId)),
                child: const ChatInfosScreen(),
              ),
            ),
          );
          if (result == "deleted") {
            Navigator.pop(context);
          } else {
            BlocProvider.of<ChatBloc>(context)
                .add(ChatNavigationDoneEvent(state.chatId));
          }
        }
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (ChatState previous, ChatState current) {
          return (true);
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return (ChatLoadingPage(chatId: state.chatId));
          } else if (state is ChatLoaded) {
            return (ChatLoadedPage(
              originalMessages: state.messages,
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
