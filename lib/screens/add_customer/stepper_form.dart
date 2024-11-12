import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kas/src/config/domain/models/request_models/home_request_model.dart';
import 'package:kas/src/config/domain/models/request_models/stepper_form_request_model.dart';
import 'package:kas/src/config/domain/models/response_models/customer_form_field_model.dart';
import 'package:kas/src/config/router/app_router.gr.dart';
import 'package:kas/src/config/router/router_path.dart';
import 'package:kas/src/presentation/cubits/earnings_cubit.dart';
import 'package:kas/src/presentation/cubits/home_cubit.dart';
import 'package:kas/src/presentation/cubits/stepper_cubit.dart';
import 'package:kas/src/presentation/cubits/stepper_form_cubit.dart';
import 'package:kas/src/presentation/states/stepper_form_state.dart';
import 'package:kas/src/presentation/states/stepper_state.dart';
import 'package:kas/src/presentation/views/add_customer/step_form2.dart';
import 'package:kas/src/presentation/views/add_customer/step_form3.dart';
import 'package:kas/src/presentation/views/add_customer/step_form4.dart';
import 'package:kas/src/presentation/views/add_customer/stepper_form1.dart';
import 'package:kas/src/presentation/views/utils/constant.dart';
import 'package:kas/src/presentation/views/utils/constants/api_constants.dart';
import 'package:kas/src/presentation/views/utils/constants/sharedpreference_help.dart';
import 'package:kas/src/presentation/views/utils/enums.dart';
import 'package:kas/src/presentation/widgets/button_widget.dart';
import 'package:kas/src/presentation/widgets/indicator_widget.dart';
import 'package:kas/src/presentation/widgets/text_view_large.dart';
import 'package:kas/src/presentation/widgets/text_view_medium.dart';
import 'package:kas/src/presentation/widgets/text_view_small.dart';
import 'package:kas/src/presentation/widgets/title_app_bar_widget.dart';
import 'package:kas/src/presentation/widgets/toast_widget.dart';
@RoutePage()
// class StepperForm extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final currentStep = useState(0);
//     final formKeys = List.generate(4, (_) => useMemoized(() => GlobalKey<FormState>()));
//     final formData = useMemoized(() => StepperFormRequestModel());
//     final sharedPreferenceHelper = useState<SharedPreferenceHelper?>(null);
//     LangData langData=LangData();
// var isSubmit=useState(false);
//     useEffect(() {
//       final helper = SharedPreferenceHelper();
//       helper.init().then((_) {
//         sharedPreferenceHelper.value = helper;
//         final userId = sharedPreferenceHelper.value?.getUserId;
//         if (userId != null) {
//           context.read<StepperCubit>().login(HomeRequestModel(userId: userId, lang: sharedPreferenceHelper.value?.getLanguageCode));
//         }
//       });
//     }, []);


//     Future<void> _submitAllData(StepperFormRequestModel data) async {
//       formData.userid=sharedPreferenceHelper.value?.getUserId;
//       context.read<StepperFormCubit>().login(data);

    
//       print('API call with all data: ${data.toJson()} completed');
//     }

//     void _onStepContinue() {
//   final formKey = formKeys[currentStep.value];
//   final formState = formKey.currentState;

//   if (currentStep.value == 2) {
//     currentStep.value += 1;
//   }

//   if (formState != null && formState.validate()) {
//     formState.save();
//     if (currentStep.value < 3) {
//       currentStep.value += 1;
//     } else {
//       // If it's the last step, call the submit function
//       // _onSubmit();
//     }
//   } else {
//     // Form is not valid, show validation errors
//     formState?.validate();
//   }
// }


//     void _onSubmit() async {
//       final formKey = formKeys[currentStep.value];
//       final formState = formKey.currentState;

//       if (formState != null && formState.validate() && isSubmit.value==false ) {
//         formState.save();
//         await _submitAllData(formData);
//        isSubmit.value=true;
//         // context.read<HomeCubit>().login(HomeRequestModel(userId: ApiConstant.userId,lang: ApiConstant.langCode));
//       } else {
//         formState?.validate();
//       }
//     }
// void _goToStep1() {
    
//       currentStep.value =0;
 
//   }
//   void _goToStep2() {
    
//       currentStep.value =2;
 
//   }
//     void _onStepCancel() {
//       if (currentStep.value > 0) {
//         currentStep.value -= 1;
//       }
//     }

//     void _onStepTapped(int step) {
//       if (step < currentStep.value) {
//         currentStep.value = step;
//       }
//     }
// double swidth = MediaQuery.of(context).size.width;
//     double sheight = MediaQuery.of(context).size.height;
//     return BlocConsumer<StepperCubit, StepperState>(
//             listener: (context, state) {
//               // Handle state changes
       
//             },
            
//             builder: (context, state) {
//               if(state.networkStatusEnum==NetworkStatusEnum.loading){
//                 return CircularProgressIndicatorWidget();
//               }
//            else if(state.networkStatusEnum==NetworkStatusEnum.loaded){
// langData=state.model.data!.langData!; 
//      return WillPopScope(
//         onWillPop: () async {
//            print( state.model.data?.langData?.leaveCustomerForm);
//           // Show the alert dialog when back button is pressed
//            return await _showDialog(
//               context,
//               langData?.leaveCustomerForm,
//              langData?.yes,
//               langData?.no,
//             ) ?? false;
//         },
//         child: Scaffold(
//           appBar: TitleAppBarWidget(title: 'Customer Form'),
//           body:
//                Column(
//                 children: [
//                   Expanded(
//                     child: Theme(
//                       data: ThemeData(
//                         colorScheme: Theme.of(context).colorScheme.copyWith(
//                           primary: appColor,
//                           secondary: Colors.green,
//                         ),
//                       ),
//                       child: Stepper(
//                         type: StepperType.horizontal,
//                         currentStep: currentStep.value,
//                         onStepTapped: _onStepTapped,
//                         controlsBuilder: (BuildContext context, ControlsDetails details) {
//                           // Custom controls
//                           return Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 if (currentStep.value > 0) // Show Back button if not on the first step
//                                   ButtonWidget(
//                                     onPressed: _onStepCancel,
//                                     buttonColor: whiteColor,
//                                     buttonName: state.model.data?.langData?.back??'',
//          width: swidth/3,
//                                   ),
//                                 if (currentStep.value < 3) // Show Next button if not on the last step
//                                  ButtonWidget(
//                                     onPressed:(){
//                                       // if(currentStep.value==0 ){
//                                       //   if( validateImageUploads(context,formData,state.model.data?.langData))
                                       
//                                       _onStepContinue();
        
//                                     //   }
//                                     //  else{
//                                     //    _onStepContinue();
//                                     //  }
//                                       } ,
//                                     buttonColor: appColor,
//                                     buttonName: state.model.data?.langData?.next??'',
//                                     width: swidth/3,
        
//                                   ),
//                                 if (currentStep.value == 3) // Show Submit button only on the last step
//                                    ButtonWidget(
//                                     onPressed:(){
                                   
//                                       _onSubmit();
                                     
//                                     } ,
//                                     buttonColor:isSubmit.value?Colors.green:appColor,
//                                     buttonName:isSubmit.value?'Submitting..' :state.model.data?.langData?.submit??'',
//          width: swidth/3,
//                                   ),
//                               ],
//                             ),
//                           );
//                         },
//                         steps: [
//                           Step(
//                             title: TextViewSmall(title: ''),
//                             content: Step1Form(
//                               formKey: formKeys[0],
//                               formData: formData,
//                               data: state.model.data,
//                             ),
//                             isActive: currentStep.value >= 0,
//                             state: currentStep.value == 0 ? StepState.indexed : StepState.complete,
//                           ),
//                           Step(
//                             title: TextViewSmall(title: ''),
//                             content: Step2Form(
//                               formKey: formKeys[1],
//                               formData: formData,
//                               data: state.model.data,
//                             ),
//                             isActive: currentStep.value >= 1,
//                             state: currentStep.value == 1 ? StepState.indexed : StepState.complete,
//                           ),
//                           Step(
//                             title: TextViewSmall(title: ''),
//                             content: StepForm3(
//                               formKey: formKeys[2],
//                               formData: formData,
//                               data: state.model.data,
//                               langData: state.model.data?.langData,
//                             ),
//                             isActive: currentStep.value >= 2,
//                             state: currentStep.value == 2 ? StepState.indexed : StepState.complete,
//                           ),
//                           Step(
//                             title: TextViewSmall(title: ''),
//                             content: Step4Form(
//                               formKey: formKeys[3],
//                               formData: formData,
//                               data: state.model.data,
//                               langData: state.model.data?.langData,
//                               planData:state.model.data?.planData,
//                               goToStep1:_goToStep1,
//                               goToStep2:_goToStep2 ,
        
//                             ),
//                             isActive: currentStep.value >= 3,
//                             state: currentStep.value == 3 ? StepState.indexed : StepState.complete,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )));

//             }
//             else{
//               return CircularProgressIndicatorWidget();
//             }},
//           );
//   }
// }

// bool validateImageUploads(BuildContext context, StepperFormRequestModel formData, LangData? langData) {
//   bool isValid = true;

//   // Check customer photo
//   if (formData.photo == null) {
//     isValid = false;
//    ToastWidget(message: langData?.photoRequired ?? 'Customer photo is required',).build(context) ;
//   }

//   // Check ID proof images based on selected ID type
 
//     if (formData.aadharCardFront == null && formData.panCardFront== null) {
//       isValid = false;
//      ToastWidget(message:langData?.idProofFrontRequired ?? 'Id proof fornt required').build(context)
//       ;
//     }
   
//     if (formData.aadharCardBack == null && formData.panCardBack == null) {
//       isValid = false;
//      ToastWidget(message:langData?.idProofBackRequired ?? 'PAN card photos are required').build(context);
//     }
  

//   return isValid;
// }


//   Future<bool?> _showDialog(BuildContext context, String? title, String? ok, String? no) {
//     print('$title,$ok,$no');
//     return showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content:  Column(
//           mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(ApiConstant.langCode!='ta'?'Do you Want to leave from Customer form?':'வாடிக்கையாளர் படிவத்திலிருந்து வெளியேற விரும்புகிறீர்களா?' ?? ''),
//             ],
//           ),
//           actions: <Widget>[
           
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(true); // Return true
//               },
//               child: TextViewMedium(name: ApiConstant.langCode!='ta'? 'Yes':'ஆம்', textColors: appColor),
//             ),
//              ButtonWidget(
//               onPressed: () {
//                 Navigator.of(context).pop(false); // Return false
//               },
//              buttonName:  ApiConstant.langCode!='ta'? 'No':'இல்லை',
//              buttonColor: appColor,
//              width: 100.w,
//             ),
//           ],
//         );
//       },
//     );
//   }

class StepperForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    print('main');
    final currentStep = useState(0);
    final formKeys = List.generate(4, (_) => useMemoized(() => GlobalKey<FormState>()));
    final formData = useMemoized(() => StepperFormRequestModel());
    final sharedPreferenceHelper = useState<SharedPreferenceHelper?>(null);
    final isSubmit = useState(false);
    LangData langData = LangData();

   useEffect(() {
  context.read<StepperCubit>().login(HomeRequestModel(
    userId: ApiConstant.userId,
    lang: ApiConstant.langCode,
  ));
  
  // Return a cleanup function or null if none is needed
  return null;
}, []);


    Future<void> _submitAllData(StepperFormRequestModel data) async {
      formData.userid = ApiConstant.userId;
      context.read<StepperFormCubit>().login(data);

      print('API call with all data: ${data.toJson()} completed');
    }

    void _onStepContinue() {
      final formKey = formKeys[currentStep.value];
      final formState = formKey.currentState;

      if (currentStep.value == 2) {
        currentStep.value += 1;
      }

      if (formState != null && formState.validate()) {
        formState.save();
        if (currentStep.value < 3) {
          currentStep.value += 1;
        }
      } else {
        formState?.validate();
      }
    }

    void _onSubmit() async {
      final formKey = formKeys[currentStep.value];
      final formState = formKey.currentState;

      if (formState != null && formState.validate() && isSubmit.value == false) {
        formState.save();
        isSubmit.value = true;
        await _submitAllData(formData);
        // isSubmit.value = false; // Reset after submission
      } else {
        formState?.validate();
      }
    }

    void _onStepCancel() {
      if (currentStep.value > 0) {
        currentStep.value -= 1;
      }
    }
void _goToStep1() {
    
      currentStep.value =0;
 
  }
  void _goToStep2() {
    
      currentStep.value =2;
 
  }
   void _goToStep4() {
    
      currentStep.value =3;
 
  }
    void _onStepTapped(int step) {
      if (step < currentStep.value) {
        currentStep.value = step;
      }
    }

    Future<bool?> _showDialog(BuildContext context, String? title, String? ok, String? no,String? type,String?orderId) {
      print('$title,$ok,$no');
      return showDialog<bool>(
        barrierDismissible:type!='exit'?false:true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title??''),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                   type=='exit'?
                  context.router.pop(true)
                   :
                    {context.router.pop(),
                   context.router.replace(GiftScreen(orderId:orderId ))};
                  // Return true
                },
                child: TextViewMedium(name: ok, textColors: appColor),
              ),
              ButtonWidget(
                onPressed: () {
                  type=='exit'?
                 context.router.pop(false):
                 {context.router.pop(),
                 context.router.replace(ReceiptScreen(giftid: orderId))} ;// Return false
                },
                buttonName: no??'',
                buttonColor: appColor,
                width: 100.w,
              ),
            ],
          );
        },
      );
    }

    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    return
     MultiBlocListener(
      listeners:[ BlocListener<StepperCubit, StepperState>(
        listener: (context, state) {
          // Handle state changes
        },),
         BlocListener<StepperFormCubit, StepperFormState>(
        listener: (context, state) {
         if(state.networkStatusEnum==NetworkStatusEnum.loaded&& state.model.text=='Success'){
// context.router.replace(ReceiptScreen(giftid:state.model.data?.orderId.toString() )); 
// customer: state.model.message));
_showDialog(context, langData.wantGift,  langData?.yes,
                      langData?.no,'submit',state.model.data?.orderId.toString());
  
                      
         }
else if(state.networkStatusEnum==NetworkStatusEnum.loaded&& state.model.text!='Success'){
  ToastWidget(message: state.model.message,).build(context);
}
        },
     )],
        child: BlocBuilder<StepperCubit, StepperState>(
        builder: (context, state) {
          if (state.networkStatusEnum == NetworkStatusEnum.loading) {
            return CircularProgressIndicatorWidget();
          } else if (state.networkStatusEnum == NetworkStatusEnum.loaded) {
            langData = state.model.data!.langData!;
            return WillPopScope(
              onWillPop: () async {
                if (isSubmit.value) {
                  return false; // Disable back button during submission
                }
                return await _showDialog(
                      context,
                      langData?.leaveCustomerForm,
                      langData?.yes,
                      langData?.no,
                      'exit',
                      ''
                    ) ??
                    false;
              },
              child: Stack(
                children: [
                  Scaffold(
                    appBar: TitleAppBarWidget(title: 'Customer Form'),
                    body: Column(
                      children: [
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              colorScheme: Theme.of(context).colorScheme.copyWith(
                                    primary: appColor,
                                    secondary: Colors.green,
                                  ),
                            ),
                            child: Stepper(
                              type: StepperType.horizontal,
                              currentStep: currentStep.value,
                              onStepTapped: _onStepTapped,
                              controlsBuilder: (BuildContext context, ControlsDetails details) {
                                // Custom controls
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (currentStep.value > 0)
                                        ButtonWidget(
                                          onPressed: _onStepCancel,
                                          buttonColor: whiteColor,
                                          buttonName: state.model.data?.langData?.back ?? '',
                                          width: swidth / 3,
                                        ),
                                      if (currentStep.value < 3)
                                        ButtonWidget(
                                          onPressed: _onStepContinue,
                                          buttonColor: appColor,
                                          buttonName: state.model.data?.langData?.next ?? '',
                                          width: swidth / 3,
                                        ),
                                      if (currentStep.value == 3)
                                        ButtonWidget(
                                          onPressed: _onSubmit,
                                          buttonColor: isSubmit.value ? Colors.green : appColor,
                                          buttonName: isSubmit.value ? 'Submitting..' : state.model.data?.langData?.submit ?? '',
                                          width: swidth / 3,
                                        ),
                                    ],
                                  ),
                                );
                              },
                              steps: [
                                Step(
                                  title: TextViewSmall(title: ''),
                                  content: Step1Form(
                                    formKey: formKeys[0],
                                    formData: formData,
                                    data: state.model.data,
                                  ),
                                  isActive: currentStep.value >= 0,
                                  state: currentStep.value == 0 ? StepState.indexed : StepState.complete,
                                ),
                                Step(
                                  title: TextViewSmall(title: ''),
                                  content: Step2Form(
                                    formKey: formKeys[1],
                                    formData: formData,
                                    data: state.model.data,
                                  ),
                                  isActive: currentStep.value >= 1,
                                  state: currentStep.value == 1 ? StepState.indexed : StepState.complete,
                                ),
                                Step(
                                  title: TextViewSmall(title: ''),
                                  content: StepForm3(
                                    formKey: formKeys[2],
                                    formData: formData,
                                    data: state.model.data,
                                    langData: state.model.data?.langData,
                                    goToStep4:_goToStep4,
                                  ),
                                  isActive: currentStep.value >= 2,
                                  state: currentStep.value == 2 ? StepState.indexed : StepState.complete,
                                ),
                                Step(
                                  title: TextViewSmall(title: ''),
                                  content: Step4Form(
                                    formKey: formKeys[3],
                                    formData: formData,
                                    data: state.model.data,
                                    langData: state.model.data?.langData,
                                    planData: state.model.data?.planData,
                                    goToStep1: _goToStep1,
                                    goToStep2: _goToStep2,
                                    
                                  ),
                                  isActive: currentStep.value >= 3,
                                  state: currentStep.value == 3 ? StepState.indexed : StepState.complete,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSubmit.value)
                    ModalBarrier(
                      dismissible: false,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  if (isSubmit.value)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicatorWidget();
          }
        },
           ),
     );
  }
}
