import 'package:flutter/material.dart';

import 'package:kascollection/utils/constant.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child:CircularProgressIndicator(color: appColor,));;
  }
}