import 'package:flutter/material.dart';

class TextViewMedium extends StatelessWidget {
  final String? name;
  final Color? textColors;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? fontSize;
  const TextViewMedium({Key? key,required this.name,this.textColors,this.fontWeight,this.textAlign,this.fontSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      name?? "",
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColors,fontWeight: fontWeight,fontSize: fontSize),
    );
  }
}
