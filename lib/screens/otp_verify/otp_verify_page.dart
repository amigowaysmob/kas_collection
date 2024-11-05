import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kascollection/router/router_path.dart';
import 'package:kascollection/utils/constant.dart';
import 'package:kascollection/utils/constants/sharedpreference_help.dart';
import 'package:kascollection/widgets/button_widget.dart';
import 'package:kascollection/widgets/logo_widget.dart';
import 'package:kascollection/widgets/text_view_large.dart';
import 'package:kascollection/widgets/text_view_medium.dart';
import 'package:kascollection/widgets/toast_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

@RoutePage()
class OtpVerifyPage extends StatefulWidget {
  final resendWaitTime = 59;
  String? phoneNumber;
  String? loginPhoneNumber;
  ConRegisterRequestModel? conRegisterRequestModel;
  var mobileNumber = TextEditingController();
  String? forgotMpinOtp;
  dynamic data;
  bool? isForgotMpin;
 String? loginOtp;
 String? registerOtp;
  String? mpinStatus;
  String? userName;
  OtpVerifyPage(
      {super.key,
      this.mpinStatus,
      this.conRegisterRequestModel,
      this.data,
      this.forgotMpinOtp,
      this.userName,
      this.isForgotMpin = false,
      this.loginOtp,
      this.registerOtp,
      this.phoneNumber,
      this.loginPhoneNumber});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final GlobalKey<FormState> verifyOtpKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  late SharedPreferenceHelper sharedPreferenceHelper;

  @override
  void initState() {
    _listenOtp();
    super.initState();
    sharedPreferenceHelper = SharedPreferenceHelper();
    sharedPreferenceHelper.init();
  }
 void dispose() {
    SmsAutoFill().unregisterListener();
    print("Unregistered Listener");
    super.dispose();
  }
  void _listenOtp() async {
    await SmsAutoFill().listenForCode();
    print("OTP Listen is called");
  }
  bool checkOTP(String otp, String? apiOTP) {
    if (apiOTP == otp) {
      return true;
    }
    ToastWidget(message: "Invalid OTP").build(context);
    return false;
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // backgroundColor: appBackColor,
            body: BlocConsumer<ConRegisterCubit, ConRegisterState>(
                listener: (context, state) {
      print(state.networkStatusEnum);

      if (state.networkStatusEnum == NetworkStatusEnum.loaded &&
          state.model.text == 'Success') {
       sharedPreferenceHelper.saveUserID(state.model.data?.userdata?[0].id);
       
       showCustomAlertDialog(context, state.model.data?.notifyImage,
        state.model.data?.notifyTitle, 
        state.model.data?.notifyBody);
       
    //  context.router.replaceAll([BottomNavigationRoute()]);
        }
       else if (state.networkStatusEnum == NetworkStatusEnum.loaded &&
          state.model.text != 'Success') {
        ToastWidget(message: state.model.message).build(context);
      }
    }, builder: (context, state) {
      return Padding(
// MultiBlocListener(
//           listeners: [
//             BlocListener<RegisterOtpCubit, RegisterOtpState>(
//               listener: (context, state) {
//                 if (state.networkStatusEnum == NetworkStatusEnum.loaded &&
//                     state.registerOtp.text == 'Success') {
//                   sharedPreferenceHelper?.saveUserID(state.registerOtp.data!.id);
//                   String userId = sharedPreferenceHelper.getUserId;
//                   print('user id----${userId}');
//                   ToastWidget(
//                     message: state.registerOtp.message,
//                     color: Colors.green,
//                   ).build(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CreateMpinScreen()),
//                   );
//                 } else if (state.networkStatusEnum == NetworkStatusEnum.loaded &&
//                     state.registerOtp.text != 'Success') {
//                   ToastWidget(message: state.registerOtp.message).build(context);
//                 }
//               },
//             ),
//             BlocListener<ForgotMpinCubit, ForgotMpinState>(
//               listener: (context,forgotMpinstate) {
//                 // Handle state changes from ForgotMpinCubit here
//                 if (forgotMpinstate.networkStatusEnum == NetworkStatusEnum.loaded &&
//                     forgotMpinstate.forgotMpin.text == 'Success') {
//                   forgotMpinOtp=forgotMpinstate.forgotMpin.otp;
//                   ToastWidget(message:forgotMpinstate.forgotMpin.message).build(context);
//                   // Navigate to appropriate screen or handle logic
//                 } else if (forgotMpinstate.networkStatusEnum == NetworkStatusEnum.loaded &&
//                     forgotMpinstate.forgotMpin.text != 'Success') {
//                   // Handle error scenario
//                   ToastWidget(message:forgotMpinstate.forgotMpin.message).build(context);
//                   // Display error message or retry logic
//                 }
//               },
//             ),
//           ],

//      child:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             LogoWidget(),
            const SizedBox(
              height: 20,
            ),
            TextViewMedium(
              name: "OTP Verification",
              fontWeight: FontWeight.bold,
              textColors: appColor,
              fontSize: 18,
            ),
            vericalSpaceMedium,
            TextViewMedium(
              name: "Enter the OTP sent to Your Mobile number",
              fontWeight: FontWeight.w900,
              textAlign: TextAlign.center,
              textColors: appColor,
             
              
            ),
            vericalSpaceMedium,
          
            Padding(
               padding:const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal:40),
                          child: 
              //  child: PinCodeTextField(
              //    appContext: context,
              //    length: 4,
              //    obscureText: false,
              //    animationType: AnimationType.fade,
              //    pinTheme: PinTheme(
              //      shape: PinCodeFieldShape.underline,
              //      borderRadius: BorderRadius.circular(5),
              //      fieldHeight: 35,
              //      fieldWidth: 35, // Adjusted for less space between fields
              //      activeFillColor: whiteColor,
              //      inactiveFillColor:whiteColor,
              //      selectedFillColor:  whiteColor,
              //     activeColor:greyColor,
              //      inactiveColor: greyColor,
              //      selectedColor: appColor, // Focused border color
              //      borderWidth: 1, 
              //  // Adjust border width if needed
               
              //    ),
                 
              //    animationDuration: Duration(milliseconds: 300),
              //    keyboardType: TextInputType.number,
              //    enableActiveFill: true,
               
              //    controller: otpController,
              //    textStyle: TextStyle(fontSize: 12,color: appColor), // Reduced font size
              //    onCompleted: (v) {
              //      print("Completed");
              //    },
              //    onChanged: (value) {
              //      print(value);
              //     otpController.text=value;
              //    },
              //    beforeTextPaste: (text) {
              //      print("Allowing to paste $text");
              //      return true;
              //    },
              //  ),
              PinFieldAutoFill(
                controller: otpController,
                        decoration: BoxLooseDecoration(
                          strokeColorBuilder: PinListenColorBuilder(appColor, Colors.black26),
                          bgColorBuilder: const FixedColorBuilder(Colors.white),
                          strokeWidth:1,
                          textStyle: TextStyle(
                            fontSize: 12,
                            color: appColor,
                            fontWeight: FontWeight.w600
                          )
                        ),
                        autoFocus: true,
                        cursor: Cursor(color: Colors.red, enabled: true, width: 1),
                        
                        currentCode: '',
                        onCodeSubmitted: (code) {
                        },
                        codeLength: 4,
                        onCodeChanged: (code) {
                         if(code?.length==4){
                           if (otpController.text.isEmpty) {
                    ToastWidget(
                      message: 'Please Enter OTP',
                    );
                  }
                  if (widget.isForgotMpin == true) {
                    if (checkOTP(
                        otpController.text, widget.forgotMpinOtp.toString())) {
                     context.router.replaceNamed(RouterPath.reset_mpin_path);
                    } else {
                      ToastWidget(
                        message: 'Invalid OTP',
                       
                      ).build;
                      otpController.clear();
                    }

                  }
                  else if(widget.registerOtp!=null && checkOTP(otpController.text, widget.registerOtp.toString())){
                     context
                            .read<ConRegisterCubit>()
                            .login(widget.conRegisterRequestModel!);
                  }
                   else {
                    if (checkOTP(
                        otpController.text, widget.loginOtp
                        .toString())) {
                      if (sharedPreferenceHelper.getMpinStatus == '1') {
                       
                       context.router.replaceNamed(RouterPath.verify_mpin_path);

                      } 
                       else if (sharedPreferenceHelper.getMpinStatus== '0') {
                       
                       context.router.replaceNamed(RouterPath.create_mpin_path);

                      } 
                      // else {
                      //   context
                      //       .read<ConRegisterCubit>()
                      //       .login(widget.conRegisterRequestModel!);
                      // }
                      //  context
                      //         .read<RegisterOtpCubit>()
                      //         .login(widget.registerOtpRequestModel);
                    }
                    else{
                      otpController.clear();
                    }
                  }
                
                        
                         }
                        },
                      ),
              ),
            vericalSpaceMedium,
            // widget.loginOtp != null
            //     ? TextViewSmall(title: '${widget.loginOtp}',textcolor: appColor,)
            //     : TextViewSmall(title: widget.registerOtp??widget.forgotMpinOtp,textcolor: appColor,),
              ButtonWidget(
                onPressed: () {
                 
                  if (otpController.text.isEmpty) {
                    ToastWidget(
                      message: 'Please Enter OTP',
                    );
                  }
                  if (widget.isForgotMpin == true) {
                    if (checkOTP(
                        otpController.text, widget.forgotMpinOtp.toString())) {
                     context.router.replaceNamed(RouterPath.reset_mpin_path);
                    } else {
                      ToastWidget(
                        message: 'Invalid OTP',
                       
                      ).build;
                    }

                  }
                  else if(widget.registerOtp!=null && checkOTP(otpController.text, widget.registerOtp.toString())){
                     context
                            .read<ConRegisterCubit>()
                            .login(widget.conRegisterRequestModel!);
                  }
                   else {
                    if (checkOTP(
                        otpController.text, widget.loginOtp
                        .toString())) {
                      if (sharedPreferenceHelper.getMpinStatus == '1') {
                       
                       context.router.replaceNamed(RouterPath.verify_mpin_path);

                      } 
                       else if (sharedPreferenceHelper.getMpinStatus== '0') {
                       
                       context.router.replaceNamed(RouterPath.create_mpin_path);

                      } 
                      // else {
                      //   context
                      //       .read<ConRegisterCubit>()
                      //       .login(widget.conRegisterRequestModel!);
                      // }
                      //  context
                      //         .read<RegisterOtpCubit>()
                      //         .login(widget.registerOtpRequestModel);
                    }
                  }
                },
                buttonName: 'Verify OTP',
                buttonColor: appColor)
          ],
        ),
      );
    })));
  }
}
void showCustomAlertDialog(BuildContext context,String? image,String? title,String? subtitle) {
  showDialog(
    
    barrierDismissible: false,
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
            Image.network(
              image!, // Replace with your image URL or use Image.asset for local images
              // height:sheight/5,
              // width:swidth/3,
            ),
           vericalSpaceMedium,
         TextViewLarge(title: title,textcolor: appColor,fontWeight: FontWeight.bold,),
            vericalSpaceMedium,
           TextViewMedium(name: subtitle),
           vericalSpaceMedium,
          ButtonWidget(onPressed: ()async{
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
            SystemNavigator.pop(); 
          }, buttonName: 'Close', buttonColor: appColor)
          ],
        ),
      );
    },
  );
}