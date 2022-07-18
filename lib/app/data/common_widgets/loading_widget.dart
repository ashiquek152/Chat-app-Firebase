import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:SpinKitPouringHourGlassRefined(
        duration: Duration(seconds: 3),
                color: white,
                size: 50,
              ), 
    );
  }
}
