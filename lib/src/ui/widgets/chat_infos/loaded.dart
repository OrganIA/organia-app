import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/ui/themes/themes.dart';

class ChatInfosLoadedPage extends StatefulWidget {
  final Chat chat;
  final int userId;
  final List<User> users;
  const ChatInfosLoadedPage({
    Key? key,
    required this.chat,
    required this.userId,
    required this.users,
  }) : super(key: key);

  @override
  _ChatInfosLoadedPageState createState() => _ChatInfosLoadedPageState();
}

class _ChatInfosLoadedPageState extends State<ChatInfosLoadedPage> {
  final ScrollController controller = ScrollController();

  Color getMessageColor(BuildContext context, int senderId, int currentUserId) {
    if (senderId == currentUserId) {
      return MediaQuery.of(context).platformBrightness == Brightness.light
          ? lightBlue
          : darkBlue;
    } else {
      return grey;
    }
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
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Informations",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Nom de la conversation:",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                widget.chat.chatName,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Créateur:",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                widget.users
                    .firstWhere(
                        (element) => element.id == widget.chat.creatorId)
                    .email,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Utilisateurs présents:",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: widget.users.map<Widget>(
                    (user) {
                      return (InkWell(
                        child: Card(
                          color: darkBlue,
                          elevation: 5,
                          margin: const EdgeInsets.all(2.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                user.email,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
                    },
                  ).toList(),
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
