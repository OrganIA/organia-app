import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/chats_list/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/big_button.dart';

class ChatsListLoggedInPage extends StatefulWidget {
  final String email;

  const ChatsListLoggedInPage({Key? key, required this.email})
      : super(key: key);

  @override
  _ChatsListLoggedInPageState createState() => _ChatsListLoggedInPageState();
}

class _ChatsListLoggedInPageState extends State<ChatsListLoggedInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      CupertinoIcons.person_alt_circle_fill,
                      size: 150,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.email,
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 22.0,
                          color: blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                        onTap: () {
                          // BlocProvider.of<ChatsListBloc>(context)
                          //     .add(const ChatsListLogoutEvent());
                        },
                        child: SizedBox(
                          child: BigButton(
                              buttonColor: blue,
                              textValue: "Se déconnecter",
                              textColor: Colors.white),
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
