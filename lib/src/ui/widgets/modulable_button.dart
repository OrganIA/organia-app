import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModulableButton extends StatelessWidget {
  final String textValue;
  final TextStyle? textStyle;
  final Color buttonColor;
  final Gradient? gradient;
  final BoxShape shape;
  final double width;
  final double height;
  final Color splashColor;

  const ModulableButton({
    Key? key,
    required this.textValue,
    this.buttonColor = Colors.blue,
    this.textStyle,
    this.gradient,
    this.shape = BoxShape.circle,
    this.width = 50,
    this.height = 50,
    this.splashColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          color: buttonColor,
          shape: shape,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          child: Center(
            child: Text(
              textValue,
              style: GoogleFonts.nunito(
                textStyle: textStyle,
              ),
            ),
          ),
          splashColor: splashColor,
        ),
      ),
    );
  }
}
