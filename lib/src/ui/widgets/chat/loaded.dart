import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:intl/intl.dart';

class ChatLoadedPage extends StatefulWidget {
  final List<Message> messages;
  final Chat chat;
  final int userId;
  const ChatLoadedPage(
      {Key? key,
      required this.messages,
      required this.chat,
      required this.userId})
      : super(key: key);

  @override
  _ChatLoadedPageState createState() => _ChatLoadedPageState();
}

class _ChatLoadedPageState extends State<ChatLoadedPage> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      controller.jumpTo(
        controller.position.maxScrollExtent,
      );
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  child: Text(
                    widget.chat.chatName[0].toUpperCase(),
                    style: GoogleFonts.nunito(
                      textStyle: heading2,
                    ),
                  ),
                  backgroundColor: darkBlue,
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.chat.chatName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.info_outline,
                    color: darkBlue,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  84,
              child: ListView.builder(
                controller: controller,
                itemCount: widget.messages.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment:
                          (widget.messages[index].senderId != widget.userId
                              ? Alignment.topLeft
                              : Alignment.topRight),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (widget.messages[index].senderId !=
                                      widget.userId
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              widget.messages[index].content,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(
                            DateFormat('kk:mm dd/MM/yy').format(
                                DateTime.parse(widget.messages[index].createdAt)
                                    .toLocal()),
                            style: const TextStyle(fontSize: 11),
                          ),
                          Text(
                            widget.messages[index].senderId.toString(),
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                  top: 10,
                ),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        cursorColor: darkBlue,
                        decoration: const InputDecoration(
                          hintText: "Vôtre message...",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: darkBlue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
