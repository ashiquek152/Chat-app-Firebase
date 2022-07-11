
import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
   const TextFormFieldCustom({
    Key? key,
    required this.fieldController, required this.hintTex,
  }) : super(key: key);
  

  final TextEditingController fieldController;
  final String hintTex;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      decoration: InputDecoration(
          hintText:hintTex,
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.blue.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          )),
    );
  }
}