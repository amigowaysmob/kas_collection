
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kascollection/utils/constant.dart';



class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
final Color buttonColor;
double? height;
double? width;
  ButtonWidget({
    required this.onPressed,
    required this.buttonName,
    required this.buttonColor,
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height??sheight/19,
        width:width?? swidth /1.1,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: appColor),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Center(
          child: Text(
            buttonName,
            style:  TextStyle(
              color: buttonColor!=appColor?appColor:whiteColor,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

