import 'package:flutter/material.dart';
import 'package:organia/src/ui/themes/themes.dart';

class NewChatLoadingPage extends StatefulWidget {
  const NewChatLoadingPage({Key? key}) : super(key: key);

  @override
  _NewChatLoadingPageState createState() => _NewChatLoadingPageState();
}

class _NewChatLoadingPageState extends State<NewChatLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(color: darkBlue),
      ),
    );
  }
}
