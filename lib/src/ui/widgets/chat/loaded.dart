import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/chat/bloc.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/utils/myhive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatLoadedPage extends StatefulWidget {
  final List<Message> originalMessages;
  final Chat chat;
  final int userId;
  final List<User> users;
  const ChatLoadedPage({
    Key? key,
    required this.originalMessages,
    required this.chat,
    required this.userId,
    required this.users,
  }) : super(key: key);

  @override
  _ChatLoadedPageState createState() => _ChatLoadedPageState();
}

class _ChatLoadedPageState extends State<ChatLoadedPage>
    with WidgetsBindingObserver {
  AppLifecycleState? appState;
  final TextEditingController messageController = TextEditingController();
  final List<ChatMessage> messages = [];
  late ChatUser currentUser = ChatUser(
    id: widget.userId.toString(),
    customProperties: {
      "email": widget.users
          .firstWhere((element) => element.id == widget.userId)
          .email,
    },
  );
  late WebSocketChannel channel;
  bool wasPaused = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (wasPaused) {
          BlocProvider.of<ChatBloc>(context)
              .add(ChatLoadEvent(widget.chat.chatId));
          updateMessages();
          connectWs();
          setState(() {
            wasPaused = false;
          });
        }
        break;
      case AppLifecycleState.paused:
        channel.sink.close();
        setState(() {
          wasPaused = true;
        });
        break;
      default:
        break;
    }
    setState(() {
      appState = state;
    });
  }

  void connectWs() {
    setState(() {
      channel = WebSocketChannel.connect(
        Uri.parse(
          "wss://dev.organia.savatier.fr/api/chats/ws/${widget.chat.chatId}",
        ),
        // Uri.parse(
        //   "ws://localhost:8000/api/chats/ws/${widget.chat.chatId}",
        // ),
      );
    });
    loginWebsocket();
  }

  void loginWebsocket() {
    channel.sink.add(
      json.encode(
        {
          "event": "login",
          "token": "${hive.box.get('currentHiveUser').token}",
        },
      ),
    );
    channel.stream.listen(
      (data) {
        Map<String, dynamic> decodedData = json.decode(data);
        if (decodedData["event"] == "message_received" ||
            decodedData["event"] == "message_sent") {
          setState(() {
            final Message message = Message.fromJson(decodedData["data"]);
            messages.insert(
              0,
              ChatMessage(
                user: createChatUser(message.sender.id),
                createdAt: message.createdAtOriginal,
                text: message.content,
              ),
            );
          });
        }
      },
    );
  }

  void updateMessages() {
    setState(() {
      messages.clear();
      for (Message message in widget.originalMessages.reversed) {
        messages.add(
          ChatMessage(
            user: createChatUser(message.sender.id),
            createdAt: message.createdAtOriginal,
            text: message.content,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    updateMessages();
    connectWs();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    channel.sink.close();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void sendMessage(String text) {
    text = text.trim();
    if (text == "") {
      return;
    }
    channel.sink.add(
      json.encode(
        {
          "event": "send_message",
          "data": {
            "content": text,
          },
        },
      ),
    );
    messageController.clear();
  }

  ChatUser createChatUser(int id) {
    return ChatUser(
      id: widget.users.firstWhere((element) => element.id == id).id.toString(),
      customProperties: {
        "email": widget.users.firstWhere((element) => element.id == id).email,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? darkBlue
              : Colors.white,
        ),
        backgroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? null
                : Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    channel.sink.close();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
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
                  icon: const Icon(
                    Icons.info_outline,
                  ),
                  onPressed: () {
                    BlocProvider.of<ChatBloc>(context).add(
                      ChatNavigateEvent(widget.chat.chatId),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: DashChat(
        currentUser: currentUser,
        onSend: (ChatMessage message) => sendMessage(message.text),
        inputOptions: const InputOptions(
          inputDecoration: InputDecoration(
            hintText: "Vôtre message",
          ),
        ),
        messages: messages,
        messageOptions: MessageOptions(
          userNameBuilder: (user) {
            return Text(user.customProperties!["email"]);
          },
          showOtherUsersAvatar: false,
          showTime: true,
          showOtherUsersName: true,
        ),
      ),
    );
  }
}
