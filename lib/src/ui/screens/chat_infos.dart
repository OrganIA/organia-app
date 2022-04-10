import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/chat_infos/bloc.dart';
import 'package:organia/src/ui/widgets/chat_infos/loaded.dart';
import 'package:organia/src/ui/widgets/chat_infos/loading.dart';

class ChatInfosScreen extends StatefulWidget {
  const ChatInfosScreen({Key? key}) : super(key: key);

  @override
  _ChatInfosScreenState createState() => _ChatInfosScreenState();
}

class _ChatInfosScreenState extends State<ChatInfosScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatInfosBloc, ChatInfosState>(
      listener: (context, state) async {},
      child: BlocBuilder<ChatInfosBloc, ChatInfosState>(
        buildWhen: (ChatInfosState previous, ChatInfosState current) {
          return (true);
        },
        builder: (context, state) {
          if (state is ChatInfosLoading) {
            return (ChatInfosLoadingPage(chat: state.chat));
          } else if (state is ChatInfosLoaded) {
            return (ChatInfosLoadedPage(
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
