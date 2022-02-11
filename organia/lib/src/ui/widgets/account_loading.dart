import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/account/bloc.dart';
import 'package:organia/src/utils/shared_preferences.dart';

class AccountLoadingPage extends StatefulWidget {
  const AccountLoadingPage({Key? key}) : super(key: key);

  @override
  _AccountLoadingPageState createState() => _AccountLoadingPageState();
}

class _AccountLoadingPageState extends State<AccountLoadingPage> {
  @override
  Widget build(BuildContext context) {
    MySharedPreferences().get("USER_EMAIL").then((email) {
      if (email != null && email.isNotEmpty) {
        BlocProvider.of<AccountBloc>(context).add(AccountLoginEvent(email));
      } else {
        BlocProvider.of<AccountBloc>(context).add(const AccountLogoutEvent());
      }
    });
    return const CircularProgressIndicator();
  }
}
