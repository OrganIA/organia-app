import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/account/bloc.dart';
import 'package:organia/src/models/hive/current_hive_user.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/utils/myhive.dart';

class AccountLoadingPage extends StatefulWidget {
  const AccountLoadingPage({Key? key}) : super(key: key);

  @override
  _AccountLoadingPageState createState() => _AccountLoadingPageState();
}

class _AccountLoadingPageState extends State<AccountLoadingPage> {
  @override
  Widget build(BuildContext context) {
    if (hive.box.containsKey("currentHiveUser")) {
      CurrentHiveUser currentHiveUser = hive.box.get("currentHiveUser");
      BlocProvider.of<AccountBloc>(context)
          .add(AccountAutoLoginEvent(currentHiveUser.token));
    } else {
      BlocProvider.of<AccountBloc>(context).add(const AccountLogoutEvent());
    }
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(color: darkBlue),
      ),
    );
  }
}
