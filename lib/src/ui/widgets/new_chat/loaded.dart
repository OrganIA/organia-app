import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/new_chat/bloc.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/big_button.dart';

class NewChatLoadedPage extends StatefulWidget {
  final List<User> users;
  const NewChatLoadedPage({Key? key, required this.users}) : super(key: key);

  @override
  _NewChatLoadedPageState createState() => _NewChatLoadedPageState();
}

class _NewChatLoadedPageState extends State<NewChatLoadedPage> {
  TextEditingController chatNameController = TextEditingController();
  List<User> usersNotAdded = [];
  List<User> usersToAdd = [];
  @override
  Widget build(BuildContext context) {
    setState(() {
      usersNotAdded = widget.users;
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Nouvelle Conversation",
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: chatNameController,
                decoration: InputDecoration(
                  hintText: "Nom de la conversation",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
                style: GoogleFonts.nunito(),
              ),
            ),
            Center(
              child: Text(
                "Utilisateurs ajoutés",
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: black,
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
                  children: usersToAdd.map<Widget>(
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
                        onTap: () {
                          setState(() {
                            usersNotAdded.add(user);
                            usersToAdd
                                .removeWhere((element) => user == element);
                          });
                        },
                      ));
                    },
                  ).toList(),
                  shrinkWrap: true,
                ),
              ),
            ),
            Center(
              child: Text(
                "Utilisateurs non ajoutés",
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: usersNotAdded.map<Widget>(
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
                              onTap: () {
                                setState(() {
                                  usersToAdd.add(user);
                                  usersNotAdded.removeWhere(
                                      (element) => user == element);
                                });
                              },
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
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: BigButton(
                  buttonColor: darkBlue,
                  textColor: Colors.white,
                  textValue: "Créer",
                ),
              ),
              onTap: () {
                if (chatNameController.text.isEmpty || usersToAdd.isEmpty) {
                  final snackBar = SnackBar(
                    duration: const Duration(seconds: 2),
                    content: Text(
                      'Erreur aucun nom ou utilisateur fourni',
                      style: GoogleFonts.nunito(),
                    ),
                    backgroundColor: red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  BlocProvider.of<NewChatBloc>(context).add(
                    NewChatCreateEvent(
                      chatNameController.text,
                      usersToAdd,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
