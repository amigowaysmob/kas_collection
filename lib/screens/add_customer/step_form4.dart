import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kas/src/config/domain/models/request_models/stepper_form_request_model.dart';
import 'package:kas/src/config/router/app_router.gr.dart';
import 'package:kas/src/config/router/router_path.dart';
import 'package:kas/src/presentation/cubits/stepper_form_cubit.dart';
import 'package:kas/src/presentation/states/stepper_form_state.dart';
import 'package:kas/src/presentation/views/add_customer/heading_widget.dart';
import 'package:kas/src/presentation/views/add_customer/stepper_form1.dart';
import 'package:kas/src/presentation/views/utils/constant.dart';
import 'package:kas/src/presentation/views/utils/enums.dart';
import 'package:kas/src/presentation/widgets/button_widget.dart';
import 'package:kas/src/presentation/widgets/divider_widget.dart';
import 'package:kas/src/presentation/widgets/drop_down_widget.dart';
import 'package:kas/src/presentation/widgets/text_form_widget.dart';
import 'package:kas/src/presentation/widgets/text_view_large.dart';
import 'package:kas/src/presentation/widgets/text_view_medium.dart';
import 'package:kas/src/presentation/widgets/text_view_small.dart';
import 'package:kas/src/presentation/widgets/toast_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;
import '../../../config/domain/models/response_models/customer_form_field_model.dart';

class Step4Form extends HookWidget {
  final GlobalKey<FormState> formKey;
  final StepperFormRequestModel formData;
  Data? data;
  LangData? langData;
  VoidCallback? goToStep1;
  VoidCallback? goToStep2;
  PlanData? planData;
   List<String>? paymentModes;
  Step4Form(
      {required this.formKey,
      required this.formData,
      required this.data,
      required this.langData,
      required this.goToStep1,
       required this.goToStep2,
       required this.planData,
       });
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter the field';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    print('step4');
    final count = useState(1);

    int number = int.parse(formData?.dailyDue??'1' );
    var payable = useState(number);
    var isChecked = useState(false);
    var isUpi=useState(false);
useEffect(() {
    // Force payable to update based on initial number
    
    payable.value = count.value * number;
    formData.payable_amount=payable.value.toString();
    return null;
  }, [formData.dailyDue]); 
    void _increment() {
     int dailycount=int.parse(formData.due_count_limit??'5');
    
      if(count.value< dailycount ){
      count.value++;
      
      payable.value = count.value * number;
       formData.dueCount=count.value;
       formData.payable_amount=payable.value.toString();
      }
    }
     final isBottomSheetVisible = useState(false);
    final imagePath = useState<File?>(null);
    final picker = ImagePicker();
    final districtData =
        data?.districtData!.map<String>((type) => type.name!).toList();
    Future<void> getImage(
      ImageSource source
    ) async {
      final image = await picker.pickImage(source: source);
     if (image != null) {
    imagePath.value = File(image.path);
    formData.paymentScreenshot=imagePath?.value;
    print(formData.paymentScreenshot);
    // Ensure the file path is set in formData
  
  }
 
    }
      String? _validateImage(File? image) {
      
  if (image == null) {
    // return langData?.imageRequired ?? 
   
    return 'Payment screen shot is required';
   }
 
  return null;
}

 void _onTermsOfUseTap() {
    context.router.pushNamed(RouterPath.terms_path);
  }

  void _onPrivacyPolicyTap() {
   
   context.router.pushNamed(RouterPath.privacy_path);
  }
bool validateImageUploads() {
      bool isValid = true;
      if (formData.customerIdType == langData?.aadharCard) {
        if (formData.aadharCardFront == null || formData.aadharCardBack == null) {
          isValid = false;
        }
      } else if (formData.customerIdType == langData?.panCard) {
        if (formData.panCardFront == null || formData.panCardBack == null) {
          isValid = false;
        }
      }
      return isValid;
    }
    Future<void> showImagePickerOptions(BuildContext context) async {
      isBottomSheetVisible.value = !isBottomSheetVisible.value;

   
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Uncomment if you want to add camera option
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            );
          },
        );
      //  else {
      //   Navigator.pop(context); // Close the bottom sheet if it's already open
      // }
    }
if(data?.paymentModes?.length==1){
  formData.paymentMode=data?.paymentModes?.first;
}

print(formData?.paymentMode);
 double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    void _decrement() {
      if (count.value > 1) {
        count.value--;
        payable.value = count.value * number;
        formData.dueCount=count.value;
        formData.payable_amount=payable.value.toString();
      }
    }
     String _addCommaIfNotEmpty(String? value, bool? isLast) {
      return value != null && value.isNotEmpty
          ? (isLast ?? true)
              ? "$value ,"
              : "$value"
          : "";
    }
 String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return langData?.addTransactionId;
    }

    return null;
  }
    // return  
//     BlocConsumer<StepperFormCubit, StepperFormState>(
//         listener: (context, state) {
//          if(state.networkStatusEnum==NetworkStatusEnum.loaded&& state.model.text=='Success'){
// context.router.replace(ReceiptScreen(receipt: langData?.downloadReceipt, close:langData?.close, link: state.model.link, 
// customer: state.model.message));

//          }
// else if(state.networkStatusEnum==NetworkStatusEnum.loaded&& state.model.text=='Success'){
//   ToastWidget(message: state.model.message,).build(context);
// }
//         },
//         builder: (context, state) {

          String? dailyDue(){
            if(formData.plan_type=='daily')
            return langData?.dailyDue;
            else if(formData.plan_type=='weekly'){
              return langData?.weekly_due;
              
            }
            else 
            return langData?.monthly_due;
          }
          return
    SingleChildScrollView(
      child: Form(
        key:formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingWidget(title: langData?.paymentMode),
            vericalSpaceLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextViewMedium(
                  name: langData?.customerDetails,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
                InkWell(
                  onTap: goToStep1,
                  child: Text(
                    langData?.change ?? '',
                    style: TextStyle(
                        decorationColor: appColor,
                        decoration: TextDecoration.underline,
                        color: appColor,
                        fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            vericalSpaceLarge,
            Row(
              children: [
                TextViewSmall(
                  title: '${langData?.customerName} : ',
                  fontWeight: FontWeight.w700,
                ),
                TextViewSmall(
                  title: formData.fullName,
                 
                )
              ],
            ),
            vericalSpaceMedium,
            Row(
              children: [
                TextViewSmall(
                  title: '${langData?.customerAddress} : ',
                  fontWeight: FontWeight.w700,
                ),
                Expanded(
                    child: TextViewSmall(
                  title:
                      '${_addCommaIfNotEmpty( formData.area, true) }${_addCommaIfNotEmpty( formData.address,true)}${_addCommaIfNotEmpty( formData.district, true)}${_addCommaIfNotEmpty( formData.area, false)}',
                
                ))
              ],
            ),
            vericalSpaceMedium,
            DividerWidget(
              color: greyColor,
            ),
            vericalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextViewMedium(
                  name: langData?.orderSummary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                InkWell(
                  onTap: goToStep2,
                  child: Text(
                    langData?.change ?? '',
                    style: TextStyle(
                        decorationColor: appColor,
                        decoration: TextDecoration.underline,
                        color: appColor,
                        fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            vericalSpaceLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextViewSmall(
                  title: '${langData?.planName??''}',
                  
                ),
                TextViewSmall(
                  title: '${formData.planName??''}',
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            vericalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextViewSmall(
                  title: '${langData?.duration??''}',
                  
                ),
                TextViewSmall(
                  title: '${formData.duration??''}',
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            vericalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextViewSmall(
                  title: dailyDue(),
                 
                ),
                TextViewSmall(
                  title: '${formData.dailyDue??''}',
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            vericalSpaceMedium,
         int.parse(formData.due_count_limit??'1')>1?     Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextViewSmall(
                  title: '${langData?.dueCount??''}',
                 
                ),
         
        
                Row(
                  children: [
                     InkWell(
                      onTap: _decrement,
                       child: Stack(
                             children: [
                               Container(
                                 height: 20.w,
                                 width: 20.w,
                                 
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Color.fromARGB(255, 223, 242, 208),
                                 ),
                               ),
                               Positioned.fill(
                       
                                 child: Center(
                                   child:  Icon(
                                       Icons.remove,
                                       size: 10.r,
                                       color: appColor,
                                    
                                    
                                   ),
                                 ),
                               ),
                             ],
                           ),
                     ),
                 horizontalSpaceMedium,
                    TextViewSmall(
                      title: '${count?.value}',
                      fontWeight: FontWeight.w800,
                    ),
                    horizontalSpaceMedium,
                     InkWell(
                      onTap: _increment,
                       child: Stack(
                             children: [
                               Container(
                                 height: 20.w,
                                 width: 20.w,
                                 
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Color.fromARGB(255, 223, 242, 208),
                                 ),
                               ),
                       
                               Positioned.fill(
                       
                                 child: Center(
                                   child:  Icon(
                                       Icons.add,
                                       size: 10.r,
                                       color: appColor,
                                    
                                    
                                   ),
                                 ),
                               ),
                             ],
                           ),
                     ),
                  ],
                ),
              ],
            ):Container(),
            vericalSpaceMedium,
            DividerWidget(),
            vericalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextViewSmall(
                  title: '${langData?.totalPayable}',
                 
                ),
                TextViewSmall(
                  title: '${payable.value}',
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            vericalSpaceLarge,
data?.paymentModes?.length==2?           FormField<String>(
  validator: (value) {
    if (formData.paymentMode== null || formData.paymentMode!.isEmpty) {
      // Return an error message if no gift is selected
      return  'Please select Payment Mode.';
    }
    return null; // Return null if validation passes
  },
  builder: (FormFieldState<String> formFieldState) {
    return
   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       DropDownWidget(
                  items: data?.paymentModes,
                  initialValue: null,
                  labelText: langData?.paymentMode,
                  onChanged: (selectedMode) {
                    formData.paymentMode = selectedMode;
                    if(formData.paymentMode=='Online'){
                      print("${isUpi.value}");
                    isUpi.value=true;}
                    if(formData.paymentMode=='Cash'){
                      print(isUpi.value);
                      print('payment cash${formData.paymentMode}');
                    isUpi.value=false;}
                    formFieldState.didChange(selectedMode);
                  }),
                  if (formFieldState.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              formFieldState.errorText!,
              style: TextStyle(color: Colors.red),
            ),
          ), 
     ],
   );

  }) 
:Container(
              height: 50,
              width: swidth,
              child: TextViewMedium(name:'${langData?.paymentMode} : ${data?.paymentModes?[0]}',fontSize: 14,fontWeight: FontWeight.bold, ),
            ),
            vericalSpaceMedium,
     (data?.paymentModes?.length==1&&data?.paymentModes?[0]=='Online') ||     isUpi.value==true?
            TextViewMedium(
              name: '${langData?.upiDetails}',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ):Container(),
            vericalSpaceMedium,
          (data?.paymentModes?.length==1&&data?.paymentModes?[0]=='Online') ||     isUpi.value==true?  SizedBox(
            height:getMainSize(data?.qrData?.length,sheight),
            child: ListView.builder(
              physics:(data?.qrData?.length==0||data?.qrData?.length==1||data?.qrData?.length==2)? NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
            shrinkWrap: true, // Allows the ListView to be placed inside a scrollable widget
                  
              scrollDirection: Axis.vertical,
                itemCount: data?.qrData?.length,
                itemBuilder: (context,index){
            
                return Image.network(data?.qrData?[index].image??'',height: sheight/2,);
              }),
          ):
            Container(),
            vericalSpaceMedium,
            (data?.paymentModes?.length==1&&data?.paymentModes?[0]=='Online') ||     isUpi.value==true? TextViewMedium(
              name: '${langData?.uploadScreenshot}*',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ):Container(),
         (data?.paymentModes?.length==1&&data?.paymentModes?[0]=='Online') ||     isUpi.value==true?     vericalSpaceMedium:Container(),
           (data?.paymentModes?.length==1&&data?.paymentModes?[0]=='Online') ||     isUpi.value==true? 
           FormField<File?>(
                validator: (value) => _validateImage(formData.paymentScreenshot),
                builder: (formFieldState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          PhotoContainerWidget(
                            title: langData?.yourPaymentScreenshot,
                            onTap: () {
                              showImagePickerOptions(context);
                            },
                          ),
                          formData.paymentScreenshot!= null
                              ? Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Image.file(
                                      formData.paymentScreenshot!,
                                     height: sheight / 6,
                                                    width: swidth / 3,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      if (formFieldState.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            formFieldState.errorText!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              ) 
           :Container(),
           (data?.paymentModes?.length==1&&data?.paymentModes?[0]=='Online') ||     isUpi.value==true?   vericalSpaceMedium:Container(),
           (data?.paymentModes?.length==1&&data?.paymentModes?[0]=='Online') ||     isUpi.value==true?  TextViewMedium(
              name: '${langData?.addTransactionId}*',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ):Container(),
            (data?.paymentModes?.length==1&&data?.paymentModes?[0]=='Online') ||     isUpi.value==true?  vericalSpaceMedium:Container(),
         (data?.paymentModes?.length==1&&data?.paymentModes?[0]=='Online') ||     isUpi.value==true?    TextForm(
              keyboardType: TextInputType.text,
              onSaved: (value) => formData.paymentTransactionId = value,
              labelText: '${langData?.paymentTransactionId}*',
              validating: _validateUsername,
            ):Container(),
            vericalSpaceSmall,
            FormField<bool>(
                  initialValue: isChecked.value,
                  validator: (value) {
                    if (!isChecked.value) {
                      return 'You must agree to the terms and conditions';
                    }
                    return null;
                  },
                  builder: (formFieldState) {
              return Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: isChecked.value,
                          onChanged: (value) {
                            isChecked.value = value!;
                          }),
                     Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(text: 'I agree to the ',style: TextStyle(color: appColor,fontSize: 14.sp, fontFamily: 'Monoserrat')),
                                    TextSpan(
                                      text: 'Terms of Use',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color:appColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Monoserrat'
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _onTermsOfUseTap,
                                    ),
                                    TextSpan(text: '  and  ',style: TextStyle(color: appColor, fontFamily: 'Monoserrat')),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                       color:appColor,
                                        fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                           fontFamily: 'Monoserrat'
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _onPrivacyPolicyTap,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                   if (formFieldState.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              formFieldState.errorText!,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                ],
              );},
            )
          ],
        ),
      ),
    );
  }}

void showCustomAlertDialog(BuildContext context,String? title,String? link) {
   _launchURL(String url) async {
    final Uri urll = Uri.parse(url);
  if (await canLaunchUrl(urll)) {
    await launchUrl(urll);
  } else {
    throw 'Could not launch $urll';
  }
}
  showDialog(
    
   
    context: context,
    builder: (BuildContext context) {
       double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenPadding),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
         
         TextViewLarge(title: title,textcolor: blackColor,fontWeight: FontWeight.bold,),
            vericalSpaceLarge,
          
          Column(
            children: [
               ButtonWidget(onPressed: ()async{
                context.router.pop();
                Navigator.of(context).pop();
               _launchURL(link!); 
               
              }, buttonName: 'Download Receipt', buttonColor: appColor,),
             vericalSpaceMedium,
              ButtonWidget(onPressed: (){
                context.router.pop();
                Navigator.of(context).pop();
              }, buttonName: 'Close', buttonColor:whiteColor,),
               vericalSpaceMedium,
              
             
            ],
          )
          ],
        ),
      );
    },
  );
}
double? getMainSize(int? length,double? height){
   
switch(length){
   case 0:
  return 0;
  case 1:
  return height!/2;
  case 2:
  return height!/1;
  case 3:
  return height!/1.5;
  case 4:
  return height!/1.5;
   case 5:
  return height!/1.5;
   case 6:
  return height!/1.5;
   case 7:
  return height!/1.5;
  
}
}
