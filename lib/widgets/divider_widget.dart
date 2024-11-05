


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kascollection/utils/constant.dart';



class DividerWidget extends StatelessWidget {
  Color? color;
  double? width;
  double? height;
   DividerWidget({this.height,this.color,this.width});

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return  Container(
      height:height?? 1,
      color:color?? appColor,
      width: width??swidth,
    );
  }
}