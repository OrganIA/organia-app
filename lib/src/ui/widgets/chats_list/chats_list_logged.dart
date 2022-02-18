import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/chats_list/chat_element.dart';

class ChatsListLoggedInPage extends StatefulWidget {
  final List<Chat> chats;

  const ChatsListLoggedInPage({Key? key, required this.chats})
      : super(key: key);

  @override
  _ChatsListLoggedInPageState createState() => _ChatsListLoggedInPageState();
}

class _ChatsListLoggedInPageState extends State<ChatsListLoggedInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
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
                        color: blue,
                      ),
                      child: InkWell(
                        onTap: () {
                          print("new");
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.add,
                              color: darkBlue,
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
            ListView.builder(
              itemCount: widget.chats.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatElement(
                  chat: widget.chats[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
