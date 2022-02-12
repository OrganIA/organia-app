import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/login/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/login_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: blue,
        shadowColor: Colors.white,
        title: const Text("Connexion"),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadedFailure) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 5),
              content: Text('Error ${state.cause}'),
              backgroundColor: red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is LoginLoadedSuccess) {
            Navigator.pop(context, state.email);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (LoginState previous, LoginState current) {
            return (true);
          },
          builder: (context, state) {
            if (state is LoginOnPage || state is LoginLoadedFailure) {
              return (const LoginPage());
            } else if (state is LoginLoading) {
              return (const Center(
                child: CircularProgressIndicator(),
              ));
            } else if (state is LoginLoadedFailure) {
              return (Container());
            } else {
              return (Container());
            }
          },
        ),
      ),
    );
  }
}
