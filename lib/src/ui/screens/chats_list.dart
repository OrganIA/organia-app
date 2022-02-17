import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/chats_list/bloc.dart';
import 'package:organia/src/blocs/login/bloc.dart';
import 'package:organia/src/blocs/register/bloc.dart';
import 'package:organia/src/ui/screens/login.dart';
import 'package:organia/src/ui/screens/register.dart';
import 'package:organia/src/ui/widgets/chats_list/chats_list_guest.dart';
import 'package:organia/src/ui/widgets/chats_list/chats_list_loading.dart';
import 'package:organia/src/ui/widgets/chats_list/chats_list_logged.dart';

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
          BlocProvider.of<ChatsListBloc>(context)
              .add(const ChatsListNavigationDoneEvent());
        }
      },
      child: BlocBuilder<ChatsListBloc, ChatsListState>(
          buildWhen: (ChatsListState previous, ChatsListState current) {
        return (true);
      }, builder: (context, state) {
        if (state is ChatsListGuest) {
          return (const ChatsListGuestPage());
        } else if (state is ChatsListLoggedIn) {
          return (ChatsListLoggedInPage(chats: state.chats));
        } else if (state is ChatsListLoading) {
          return (const ChatsListLoadingPage());
        } else {
          return (Container());
        }
      }),
    );
  }
}
