import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/chats_list/bloc.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/chats_list/element.dart';

class ChatsListLoggedInPage extends StatefulWidget {
  final List<Chat> chats;

  const ChatsListLoggedInPage({Key? key, required this.chats})
      : super(key: key);

  @override
  _ChatsListLoggedInPageState createState() => _ChatsListLoggedInPageState();
}

class _ChatsListLoggedInPageState extends State<ChatsListLoggedInPage> {
  void sortChatList() {
    widget.chats.sort(
      (a, b) => a.chatName.toLowerCase().compareTo(b.chatName.toLowerCase()),
    );
    final List<Chat> withMessage = widget.chats
        .where(
          (element) => element.latest != null,
        )
        .toList();
    for (var i in withMessage) {
      widget.chats.removeWhere((element) => element.chatId == i.chatId);
    }
    withMessage
        .sort(((b, a) => a.latest!.createdAt.compareTo(b.latest!.createdAt)));
    withMessage.addAll(widget.chats);
    widget.chats.removeRange(0, widget.chats.length);
    widget.chats.addAll(withMessage);
  }

  @override
  Widget build(BuildContext context) {
    sortChatList();
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Conversations",
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 2,
                    bottom: 2,
                  ),
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: darkBlue,
                  ),
                  child: InkWell(
                    highlightColor: darkBlue,
                    onTap: () {
                      BlocProvider.of<ChatsListBloc>(context).add(
                          const ChatsListNavigateEvent(
                              Destination.newChat, null));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Nouvelle",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Rechercher...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
              style: GoogleFonts.nunito(),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<ChatsListBloc>(context)
                    .add(const ChatsListLoadEvent());
              },
              child: ListView(
                shrinkWrap: true,
                children: widget.chats.map<Widget>(
                  (chat) {
                    return (ChatElement(chat: chat));
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
