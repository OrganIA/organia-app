import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organia/src/blocs/register/bloc.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/ui/widgets/big_button.dart';
import 'package:phone_form_field/phone_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final lastnameController = TextEditingController();
  final firstnameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = PhoneController(
    const PhoneNumber(
      isoCode: IsoCode.FR,
      nsn: "",
    ),
  );
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Inscription",
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
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
                          key: const Key("emailRegisterField"),
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
                          textInputAction: TextInputAction.next,
                          key: const Key("lastnameRegisterField"),
                          controller: lastnameController,
                          style: GoogleFonts.nunito(),
                          decoration: InputDecoration(
                            hintText: 'Nom',
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
                          textInputAction: TextInputAction.next,
                          key: const Key("firstnameRegisterField"),
                          controller: firstnameController,
                          style: GoogleFonts.nunito(),
                          decoration: InputDecoration(
                            hintText: 'Prénom',
                            hintStyle: heading6.copyWith(color: grey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        PhoneFormField(
                          key: const Key('phoneNumberRegisterField'),
                          controller: phoneController,
                          shouldFormat: true,
                          defaultCountry: IsoCode.FR,
                          decoration: InputDecoration(
                            hintText: 'Numéro de téléphone',
                            hintStyle: heading6.copyWith(color: grey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: PhoneValidator.validMobile(),
                          countrySelectorNavigator:
                              const CountrySelectorNavigator.dialog(),
                          autofillHints: const [AutofillHints.telephoneNumber],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          key: const Key("passwordRegisterField"),
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
                            BlocProvider.of<RegisterBloc>(context).add(
                              RegisterClickOnRegisterEvent(
                                emailController.text,
                                passwordController.text,
                                firstnameController.text,
                                lastnameController.text,
                                phoneController.value!.international,
                                phoneController.value!.countryCode,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    key: const Key("registerButton"),
                    onTap: () {
                      BlocProvider.of<RegisterBloc>(context).add(
                        RegisterClickOnRegisterEvent(
                          emailController.text,
                          passwordController.text,
                          firstnameController.text,
                          lastnameController.text,
                          phoneController.value!.nsn,
                          phoneController.value!.isoCode.name,
                        ),
                      );
                    },
                    child: BigButton(
                      buttonColor: darkBlue,
                      textValue: "S'inscrire",
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<RegisterBloc>(context)
                          .add(const RegisterClickOnLoginEvent());
                    },
                    child: Center(
                      child: Text(
                        "Vous avez déjà un compte? Se connecter",
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: blue,
                          ),
                        ),
                      ),
                    ),
                    key: const Key("toLoginButton"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
