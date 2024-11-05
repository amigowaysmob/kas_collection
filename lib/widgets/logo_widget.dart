
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kascollection/utils/constants/api_constants.dart';


class LogoWidget extends StatelessWidget {
 double ? height;
 double? width;
 LogoWidget({this.height,this.width});
  @override
  Widget build(BuildContext context) {
     double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return 
    ApiConstant.logoUrl!=null &&ApiConstant.logoUrl.isNotEmpty? Image.network(
                 ApiConstant.logoUrl,
                ):Image.asset('assets/images/logo.png',height: 100,width: 100,);
  }
}