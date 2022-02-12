import 'package:flutter/material.dart';
import 'package:organia/src/ui/themes/themes.dart';

class BigButton extends StatelessWidget {
  final Color buttonColor;
  final String textValue;
  final Color textColor;

  const BigButton(
      {Key? key,
      required this.buttonColor,
      required this.textValue,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14.0),
      elevation: 0,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14.0),
            child: Center(
              child: Text(
                textValue,
                style: heading5.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
