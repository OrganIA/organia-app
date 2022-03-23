import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/ui/themes/themes.dart';

class ChatsListGuestPage extends StatefulWidget {
  const ChatsListGuestPage({Key? key}) : super(key: key);

  @override
  _ChatsListGuestPageState createState() => _ChatsListGuestPageState();
}

class _ChatsListGuestPageState extends State<ChatsListGuestPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "Vous n'êtes pas connecté.",
          style: GoogleFonts.nunito(
            textStyle: heading5,
          ),
        ),
      ),
    );
  }
}
