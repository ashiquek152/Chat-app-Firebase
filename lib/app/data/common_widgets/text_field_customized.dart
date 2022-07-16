import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
   TextFormFieldCustom({
    Key? key,
    required this.fieldController,
    required this.hintTex,
     this.maxLength =100,
    this.keyboardType = TextInputType.name,
  }) : super(key: key);

  final TextEditingController fieldController;
  final String hintTex;
   int maxLength;
  final TextInputType keyboardType;
  final String value ="";

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      maxLength: maxLength,
      keyboardType: keyboardType,
      obscureText: hintTex=="Password"||hintTex=="Confirm password"?true:false,
      onChanged: (inputValue){
        inputValue=value;
      },
      // validator: validator(),
      decoration: InputDecoration(
          hintText: hintTex,
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

  validator() {
    if (hintTex == "Password" || hintTex == "Confirm password") {
      value.length < 6 ? "Enter min 6 characters" : null;
    }else {
      return "This field required";
    }
  }
}
