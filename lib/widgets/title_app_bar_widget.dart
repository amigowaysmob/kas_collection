import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:kascollection/utils/constant.dart';
import 'package:kascollection/widgets/text_view_large.dart';

class TitleAppBarWidget extends HookWidget implements PreferredSizeWidget {
  String? title;

   TitleAppBarWidget({required this.title});
  
  @override
  Size get preferredSize => Size.fromHeight(50.0); 

  @override
  Widget build(BuildContext context) {
    
        return AppBar(
          
           backgroundColor: appColor,
         title: TextViewLarge(title: title,textcolor: whiteColor,fontWeight: FontWeight.bold,),
          );
         
   
  }}

