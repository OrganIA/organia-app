import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/chats_list/bloc.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/ui/themes/themes.dart';

class ChatElement extends StatefulWidget {
  final Chat chat;
  const ChatElement({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatElement createState() => _ChatElement();
}

class _ChatElement extends State<ChatElement> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ChatsListBloc>(context)
            .add(ChatsListNavigateEvent(Destination.chat, widget.chat));
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text(
                      widget.chat.chatName[0].toUpperCase(),
                      style: GoogleFonts.nunito(
                        textStyle: heading2,
                      ),
                    ),
                    backgroundColor: darkBlue,
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.chat.chatName,
                            style: GoogleFonts.nunito(
                              textStyle: heading5,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          if (widget.chat.latest != null) ...[
                            Text(
                              widget.chat.latest!.content,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
