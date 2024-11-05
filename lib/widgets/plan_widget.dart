import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kascollection/router/app_router.gr.dart';
import 'package:kascollection/utils/constant.dart';
import 'package:kascollection/utils/constants/api_constants.dart';
import 'package:kascollection/widgets/button_widget.dart';
import 'package:kascollection/widgets/text_view_large.dart';
import 'package:kascollection/widgets/text_view_small.dart';


class PlanWidget extends StatelessWidget {
  String?planName;
  String? durationName;
  String? duration;
  String? amountName;
  String? amount;
  String? join;
  VoidCallback? onPressed;
  Color? buttonColor;
  String? joined;
  String? click;
 final String id;
 final String? isJoined;
String? currentId;
  PlanWidget({required this.planName,required this.durationName,required this.duration,required this.amountName,
  required this.amount,required this.join,required this.onPressed,required this.buttonColor,required this.id,
 this.isJoined,required this.joined,required this.currentId,required this.click});

  @override
  Widget build(BuildContext context) {
  
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
   
    return Padding(
      padding:  EdgeInsets.all(10.0.r),
      child: Card(
        elevation: 5,
        color: whiteColor,
        child: Container(
          height:ApiConstant.langCode!='ta' ?sheight/6:sheight/5.5,
          width: swidth,
          decoration: BoxDecoration(
            border: Border.all(color: greyColor,width: 0.5),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding:  EdgeInsets.all(8.0.r),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
                children: [Container(
                  width: swidth/1.75,
                 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    TextViewLarge(title: planName,textcolor: appColor,fontWeight:FontWeight.bold,),
                    TextViewSmall(title:'${durationName}:${duration}',textcolor: appColor,),
                  
                    Expanded(child: TextViewSmall(title:'${amountName}:₹ ${amount}',textcolor: appColor,)),
                  //  InkWell(child: TextViewSmall(title: click))
                    InkWell(
                      child: Text(click??'',style:TextStyle(
                               color:blackColor,
                               fontSize: 12,
                                fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                   fontFamily: 'Monoserrat'
                              ),),
                      onTap: (){
                      context.router.push(PlanDetailScreen(planId: currentId));
                    },
                    )
                  ],
                  ),
                ),
                ButtonWidget(onPressed: onPressed!, buttonName:id==currentId?joined??'':join??'', buttonColor:id==currentId?Colors.green:appColor ,width: swidth/6,)
                ],
              
              ),
            ),
          ),
        ),
      ),
    );
  }
}