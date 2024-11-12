import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kas/src/presentation/views/utils/constant.dart';
import 'package:kas/src/presentation/widgets/divider_widget.dart';
import 'package:kas/src/presentation/widgets/text_view_large.dart';

class HeadingWidget extends StatelessWidget {
  String? title;
   HeadingWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextViewLarge(title: title,textcolor: blackColor,fontSize: 18.sp,fontWeight: FontWeight.w700,),
        vericalSpaceMedium,
       Container(
        height: 10,
        width: swidth/7,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appLightColor, appDarkColor,], // Define your gradient colors here
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),)
      ],
    );
  }
}