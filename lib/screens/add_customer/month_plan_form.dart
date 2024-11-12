import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kas/src/config/domain/models/request_models/plans_request_model.dart';
import 'package:kas/src/config/domain/models/request_models/stepper_form_request_model.dart'  ;
import 'package:kas/src/config/domain/models/request_models/stepper_form_request_model.dart';
import 'package:kas/src/config/domain/models/response_models/customer_form_field_model.dart' as s;
 import 'package:kas/src/config/domain/models/response_models/month_plans_model.dart' as m;
import 'package:kas/src/config/router/app_router.gr.dart';
import 'package:kas/src/presentation/cubits/month_plans_cubit.dart';
import 'package:kas/src/presentation/states/month_plans_state.dart';
import 'package:kas/src/presentation/views/utils/constant.dart';
import 'package:kas/src/presentation/views/utils/constants/api_constants.dart';
import 'package:kas/src/presentation/views/utils/enums.dart';
import 'package:kas/src/presentation/widgets/plan_widget.dart';
import 'package:kas/src/presentation/widgets/text_view_large.dart';
import 'package:kas/src/presentation/widgets/text_view_medium.dart';
import 'package:kas/src/presentation/widgets/title_app_bar_widget.dart';

class MonthPlanForm extends StatefulWidget {
   String? type;
   final StepperFormRequestModel?formData;
  s. LangData? langData;
  VoidCallback? goToStep4;
 MonthPlanForm({ this.type,this.formData,this.langData,this.goToStep4});

  @override
  State<MonthPlanForm> createState() => _MonthPlanFormState();
}

class _MonthPlanFormState extends State<MonthPlanForm> {
m.LangData? langData=m.LangData();
m.PlanData? planData=m.PlanData();
  
  @override
  void initState() {
    super.initState();
    context.read<MonthPlansCubit>().login(PlansRequestModel(userId: ApiConstant.userId,
    lang: ApiConstant.langCode,type: widget.type));
  }
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return 
    BlocConsumer<MonthPlansCubit, MonthPlansState>(
            listener: (context, state) {
           
      if (state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text=='Success') {
   
      }
      else if(state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text!='Success'){

      }
    },
     builder: (context, state) {
     if(  state.networkStatusEnum==NetworkStatusEnum.loading){
      return Center(child: CircularProgressIndicator(color: appColor,));
    }
    if( state.networkStatusEnum==NetworkStatusEnum.loaded){
 langData= state.model.data?.langData;
 planData=state.model.data?.planData;
print(langData);
print(planData);
     return 
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[  
        
            ExpansionTile(
              iconColor: appColor,
              title:Container(
               child: Center(
            child: TextViewMedium(name: 'Ponmagal Gold Plan',textColors: appColor,fontWeight: FontWeight.bold,),
          ),
            ) ,
            children: [
              SizedBox(
            // height: sheight/1.4,
            child: ListView.builder(
               shrinkWrap:true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:planData?.ponmagal?.length,
              itemBuilder: (context,index){
                var plan=planData?.ponmagal?[index];
              return 
             PlanWidget(

currentId:plan?.id,
            id:widget.formData?.plan??'',
            planName: plan?.planName,
            durationName: langData?.duration,
            duration: plan?.duration,
            amountName: langData?.payable,
            amount: plan?.planAmount,
click:widget.langData?.clickHereMoreDetails,
            join:
            //  isJoined.value==formData.plan? langData?.joined:
             widget.langData?.join,
              joined:widget.langData?.joined,
            buttonColor:
            // isJoined.value==formData.plan? Colors.green:
            appColor,
            onPressed: () {
           
            
                              // selectedPlanId = plan?.id;
                              widget.formData?.plan = plan?.id;
                              widget.formData?.planName = plan?.planName;
                              widget.formData?.duration = plan?.duration;
                              widget.formData?.dailyDue = plan?.planAmount;
                              widget.formData?.plan_type = plan?.planType;
                              widget.formData?.due_count_limit = plan?.dueCountLimit;
                        widget.goToStep4?.call();
          //  widget.  formData?.plan=plan?.id;

           
          //    widget.formData?.planName=plan?.planName;
          //    widget.formData?.duration=plan?.duration;
          //    widget.formData?.dailyDue=plan?.planAmount;
          //    widget.formData?.plan_type=plan?.planType;
          //    widget.formData?.due_count_limit=plan?.dueCountLimit;
            },
          );                       }
                  ),
                ),
              
            ]),
        
                
      
         ExpansionTile(
            iconColor: appColor,title:Container(
               child: Center(
            child: TextViewMedium(name: 'Virutcham Gold Plan',textColors: appColor,fontWeight: FontWeight.bold,),
          ),
            ) ,
            children: [
            SizedBox(
            // height: sheight/1.45,
            child: ListView.builder(
              shrinkWrap:true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:planData?.virucham?.length,
              itemBuilder: (context,index){
                var plan=planData?.virucham?[index];
              return 
             PlanWidget(

currentId:plan?.id,
            id:widget.formData?.plan??'',
            planName: plan?.planName,
            durationName: langData?.duration,
            duration: plan?.duration,
            amountName: langData?.payable,
            amount: plan?.planAmount,
click:widget.langData?.clickHereMoreDetails,
            join:
            //  isJoined.value==formData.plan? langData?.joined:
             widget.langData?.join,
              joined:widget.langData?.joined,
            buttonColor:
            // isJoined.value==formData.plan? Colors.green:
            appColor,
            onPressed: () {
           
           widget.  formData?.plan=plan?.id;

           print(widget.formData?.plan);
           
        widget.  formData?.plan==   plan?.id?print('green color'):print('appcolor');
             widget.formData?.planName=plan?.planName;
             widget.formData?.duration=plan?.duration;
             widget.formData?.dailyDue=plan?.planAmount;
             widget.formData?.plan_type=plan?.planType;
             widget.formData?.due_count_limit=plan?.dueCountLimit;
              widget.goToStep4?.call();
            },
          );                       }
                  ),
                ),
                
        ])
            ],);
        
        
        
          
    
        
      
    } 
else
return CircularProgressIndicator();
}
  
  );}}