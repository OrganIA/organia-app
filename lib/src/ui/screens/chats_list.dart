import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/chat/bloc.dart';
import 'package:organia/src/blocs/chats_list/bloc.dart';
import 'package:organia/src/blocs/new_chat/bloc.dart';
import 'package:organia/src/ui/screens/chat.dart';
import 'package:organia/src/ui/screens/new_chat.dart';
import 'package:organia/src/ui/widgets/chats_list/guest.dart';
import 'package:organia/src/ui/widgets/chats_list/loading.dart';
import 'package:organia/src/ui/widgets/chats_list/loaded.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({Key? key}) : super(key: key);

  @override
  _ChatsListScreenState createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatsListBloc, ChatsListState>(
      listener: (context, state) async {
        if (state is ChatsListNavigate) {
          if (state.to == Destination.chat && state.chat != null) {
            await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) =>
                      ChatBloc(ChatLoading(state.chat!), state.chat!),
                  child: const ChatScreen(),
                ),
              ),
            );
          } else if (state.to == Destination.newChat) {
            await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => NewChatBloc(),
                  child: const NewChatScreen(),
                ),
              ),
            );
            BlocProvider.of<ChatsListBloc>(context)
                .add(const ChatsListReLoadEvent());
            return;
          }
          BlocProvider.of<ChatsListBloc>(context)
              .add(const ChatsListNavigationDoneEvent());
        }
      },
      child: BlocBuilder<ChatsListBloc, ChatsListState>(
        buildWhen: (ChatsListState previous, ChatsListState current) {
          return (true);
        },
        builder: (context, state) {
          if (state is ChatsListGuest) {
            return (const ChatsListGuestPage());
          } else if (state is ChatsListLoggedIn) {
            return (ChatsListLoggedInPage(chats: state.chats));
          } else if (state is ChatsListLoading) {
            return (const ChatsListLoadingPage());
          } else {
            return (Container());
          }
        },
      ),
    );
  }
}
