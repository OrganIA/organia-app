import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/login/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/big_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Connexion",
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
        iconTheme: IconThemeData(
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? darkBlue
              : Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        key: const Key("emailLoginField"),
                        controller: emailController,
                        style: GoogleFonts.nunito(),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: heading6.copyWith(color: grey),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        key: const Key("passwordLoginField"),
                        controller: passwordController,
                        obscureText: !passwordVisible,
                        style: GoogleFonts.nunito(),
                        decoration: InputDecoration(
                          hintText: 'Mot de passe',
                          hintStyle: heading6.copyWith(color: grey),
                          suffixIcon: IconButton(
                            color: grey,
                            splashRadius: 1,
                            icon: Icon(passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: togglePassword,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onFieldSubmitted: (_) {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginClickOnLoginEvent(emailController.text,
                                  passwordController.text));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                GestureDetector(
                  key: const Key("loginButton"),
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    BlocProvider.of<LoginBloc>(context).add(
                        LoginClickOnLoginEvent(
                            emailController.text, passwordController.text));
                  },
                  child: BigButton(
                    buttonColor: darkBlue,
                    textValue: "Se connecter",
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<LoginBloc>(context)
                        .add(const LoginClickOnRegisterEvent());
                  },
                  child: Center(
                    child: Text(
                      "Pas encore de compte? S'inscrire",
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          color: blue,
                        ),
                      ),
                    ),
                  ),
                  key: const Key("toRegisterButton"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
