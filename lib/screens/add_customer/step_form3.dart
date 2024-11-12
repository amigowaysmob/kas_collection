import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kas/src/config/domain/models/request_models/stepper_form_request_model.dart';
import 'package:kas/src/config/router/app_router.gr.dart';
import 'package:kas/src/presentation/views/add_customer/heading_widget.dart';
import 'package:kas/src/presentation/views/add_customer/month_plan_form.dart';
import 'package:kas/src/presentation/views/utils/constant.dart';
import 'package:kas/src/presentation/widgets/button_widget.dart';
import 'package:kas/src/presentation/widgets/plan_widget.dart';
import 'package:kas/src/presentation/widgets/text_form_widget.dart';
import 'package:kas/src/presentation/widgets/text_view_large.dart';
import 'package:kas/src/presentation/widgets/text_view_small.dart';

import '../../../config/domain/models/response_models/customer_form_field_model.dart';

class StepForm3 extends HookWidget {
  final GlobalKey<FormState> formKey;
  final StepperFormRequestModel formData;
  final Data? data;
  final LangData? langData;
 VoidCallback? goToStep4;
  StepForm3({
    required this.formKey,
    required this.formData,
    required this.data,
    required this.langData,
    required this.goToStep4
  });

  @override
  Widget build(BuildContext context) {
    print('step3');
    final isExpandedd = useState<List<bool>>([false, false, false]);
    final isLoading = useState(true);
final isJoined=useState(false);
    PlanData? planData = data?.planData;
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    useEffect(() {
      // Simulate a delay to mock fetching data
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
      });

      return null;
    }, []);

    if (isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingWidget(title: langData?.selectYourPlan),
          vericalSpaceLarge,
          ExpansionPanelList(
           expansionCallback: (int index, bool isExpanded) {
              final newExpandedState = List<bool>.from(isExpandedd.value);
              newExpandedState[index] = !newExpandedState[index];
              isExpandedd.value = newExpandedState;
            },
            children: [
              _buildExpansionPanel(
               langData?.dailyGoldPlan?? '',
                planData?.daily,
                0,
                isExpandedd.value,
              ),
            
              _buildExpansionPanel(
                langData?.weeklyGoldPlan ?? '',
                planData?.weekly,
                1,
                isExpandedd.value,
              ),
              _buildExpansionPanel(
                langData?.monthlyGoldPlan ?? '',
                planData?.monthly,
                2,
                isExpandedd.value,
              ),
            ],
          ),
        ],
      ),
    );
  }

  ExpansionPanel _buildExpansionPanel(
      String header, List<Plan>? plans, int index, List<bool> isExpanded) {
        var isJoined=useState('');
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
         double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
        return Container(
          width: swidth,
          color: appColor,
         child: Center(child: TextViewLarge(title: header),),
        );
      },
      body:
      index==2?MonthPlanForm(formData: formData,langData: langData,goToStep4:goToStep4):
       Column(

        children: plans?.map((plan) {
          var amountName;
          if (index == 0) {
            amountName = langData?.payableInDays;
          } else if (index == 1) {
            amountName = langData?.payableInWeeks;
          } else {
            amountName = langData?.payableInMonths;
          }
      var planIndex = plans!.indexOf(plan);
      print(planIndex);
      
          return PlanWidget(
isJoined:isJoined.value,
currentId:plan.id,
            id:formData.plan??'',
            planName: plan.planName,
            durationName: langData?.duration,
            duration: plan.duration,
            amountName: amountName,
            amount: plan.planAmount,
click:langData?.clickHereMoreDetails,
            join:
            //  isJoined.value==formData.plan? langData?.joined:
             langData?.join,
              joined:langData?.joined,
            buttonColor:
            // isJoined.value==formData.plan? Colors.green:
            appColor,
            onPressed: () {
             isJoined.value=plan.id??'';
             formData.plan=plan.id;

             print( isJoined.value) ;
             print(formData.plan);
             formData.planName=plan.planName;
             formData.duration=plan.duration;
             formData.dailyDue=plan.planAmount;
             formData.plan_type=plan.planType;
             formData.due_count_limit=plan.dueCountLimit;
             goToStep4?.call();
            },
          );
        }).toList() ?? [],
      ),
      isExpanded: isExpanded[index],
    );
  }
}

