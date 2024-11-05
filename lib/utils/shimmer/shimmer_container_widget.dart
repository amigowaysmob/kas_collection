
import 'package:flutter/material.dart';

import 'package:kascollection/utils/constant.dart';


class ShimmerContainerWidget extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerContainerWidget(this.height, this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: whiteColor),
    );
  }
}
