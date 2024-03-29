import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/login/bloc.dart';
import 'package:organia/src/blocs/register/bloc.dart';
import 'package:organia/src/ui/screens/login.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/register_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadedFailure) {
          var snackBar = SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(
              state.cause,
              style: GoogleFonts.nunito(),
            ),
            backgroundColor: red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is RegisterNavigateToLogin) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => LoginBloc(),
                child: const LoginScreen(),
              ),
            ),
          );
        }
        if (state is RegisterLoadedSuccess) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (RegisterState previous, RegisterState current) {
        return (true);
      }, builder: (context, state) {
        if (state is RegisterOnPage || state is RegisterLoadedFailure) {
          return (const RegisterPage());
        } else if (state is RegisterLoading) {
          return (const Center(
            child: CircularProgressIndicator(),
          ));
        } else if (state is RegisterLoadedFailure) {
          return (Container());
        } else {
          return (Container());
        }
      }),
    );
  }
}
