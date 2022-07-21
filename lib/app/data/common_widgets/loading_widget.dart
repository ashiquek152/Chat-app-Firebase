import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key,this.duration =5}) : super(key: key);
  final int duration;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child:SpinKitPouringHourGlassRefined(
        duration: Duration(seconds: duration),
                color: white,
                size: 50,
              ), 
    );
  }
}
