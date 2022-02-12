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
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<AccountBloc>(context)
                        .add(const AccountNavigateEvent("login"));
                  },
                  child: BigButton(
                      buttonColor: blue,
                      textValue: "Login",
                      textColor: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<AccountBloc>(context)
                        .add(const AccountNavigateEvent("register"));
                  },
                  child: BigButton(
                      buttonColor: blue,
                      textValue: "Register",
                      textColor: Colors.white),
                ),
              ],
            )));
  }
}
