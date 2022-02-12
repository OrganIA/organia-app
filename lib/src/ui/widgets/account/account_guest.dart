// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/account/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/big_button.dart';

class AccountGuestPage extends StatefulWidget {
  const AccountGuestPage({Key? key}) : super(key: key);

  @override
  _AccountGuestPageState createState() => _AccountGuestPageState();
}

class _AccountGuestPageState extends State<AccountGuestPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                BlocProvider.of<AccountBloc>(context)
                    .add(const AccountNavigateEvent("login"));
              },
              child: BigButton(
                  buttonColor: blue,
                  textValue: "Se connecter",
                  textColor: Colors.white),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<AccountBloc>(context)
                    .add(const AccountNavigateEvent("register"));
              },
              child: BigButton(
                  buttonColor: blue,
                  textValue: "S'inscrire",
                  textColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
