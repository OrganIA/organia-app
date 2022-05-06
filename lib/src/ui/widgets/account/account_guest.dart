import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Authentification",
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? black
                      : Colors.white,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                key: const Key("loginBigButton"),
                onTap: () {
                  BlocProvider.of<AccountBloc>(context)
                      .add(const AccountNavigateEvent("login"));
                },
                child: BigButton(
                    buttonColor: darkBlue,
                    textValue: "Se connecter",
                    textColor: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              GestureDetector(
                key: const Key("registerBigButton"),
                onTap: () {
                  BlocProvider.of<AccountBloc>(context)
                      .add(const AccountNavigateEvent("register"));
                },
                child: BigButton(
                  buttonColor: darkBlue,
                  textValue: "S'inscrire",
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
