import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/account/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/big_button.dart';

class AccountLoggedInPage extends StatefulWidget {
  final String email;

  const AccountLoggedInPage({Key? key, required this.email}) : super(key: key);

  @override
  _AccountLoggedInPageState createState() => _AccountLoggedInPageState();
}

class _AccountLoggedInPageState extends State<AccountLoggedInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Votre compte",
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Scaffold(
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
                          BlocProvider.of<AccountBloc>(context)
                              .add(const AccountLogoutEvent());
                        },
                        child: SizedBox(
                          child: BigButton(
                              buttonColor: darkBlue,
                              textValue: "Se déconnecter",
                              textColor: Colors.white),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
