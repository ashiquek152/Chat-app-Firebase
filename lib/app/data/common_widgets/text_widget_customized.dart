import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextCustomized extends StatelessWidget {
  TextCustomized(
      {Key? key,
      required this.text,
      required this.textSize,
      required this.textColor,
       this.fontWeight =FontWeight.normal})
      : super(key: key);

  final String text;
  final double textSize;
  final Color textColor;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:  TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: fontWeight
      ),
    );
  }
}
