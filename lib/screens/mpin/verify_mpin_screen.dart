import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kascollection/cubits/forgot_mpin_cubit.dart';
import 'package:kascollection/cubits/login_mpin_cubit.dart';

import 'package:kascollection/states/forgot_mpin_state.dart';
import 'package:kascollection/states/login_mpin_state.dart';
import 'package:kascollection/utils/constant.dart';
import 'package:kascollection/utils/constants/sharedpreference_help.dart';
import 'package:kascollection/utils/enums.dart';
import 'package:kascollection/utils/firebase_helper.dart';
import 'package:kascollection/widgets/button_widget.dart';
import 'package:kascollection/widgets/indicator_widget.dart';
import 'package:kascollection/widgets/logo_widget.dart';
import 'package:kascollection/widgets/text_view_large.dart';
import 'package:kascollection/widgets/text_view_medium.dart';
import 'package:kascollection/widgets/text_view_small.dart';
import 'package:kascollection/widgets/toast_widget.dart';


import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
@RoutePage()
class VerifyMpinScreen extends StatefulWidget {
 String? phoneNumber;

VerifyMpinScreen({ this.phoneNumber});
  @override
  State<VerifyMpinScreen> createState() => _VerifyMpinScreenState();
}

class _VerifyMpinScreenState extends State<VerifyMpinScreen> {
   final GlobalKey<FormState> verifyMpinKey = GlobalKey<FormState>();
  TextEditingController verifyMpinController=TextEditingController();
 late SharedPreferenceHelper sharedPreferenceHelper;
 int?forgotMpinOtp;
  @override
   void initState() {
    super.initState();
    _initRemoteConfig();
    sharedPreferenceHelper = SharedPreferenceHelper();
    sharedPreferenceHelper.init();
     
   }
   Future<void> _initRemoteConfig() async {
      print('Initializing Remote Config');
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      print('Current version-----: $currentVersion');

      FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
      await _remoteConfig.fetchAndActivate();
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      _remoteConfig.onConfigUpdated.listen((event) async {
        await _remoteConfig.activate();
      });

      String remoteVersion = _remoteConfig
          .getString(Platform.isIOS ? 'ios_remoteVersion' : 'remoteVersion');
      String minAppVersion = _remoteConfig
          .getString(Platform.isIOS ? 'ios_minAppVersion' : 'minAppVersion');

      int getExtendedVersionNumber(String version) {
        List versionCells = version.split('.');
        versionCells = versionCells.map((i) => int.parse(i)).toList();
        return versionCells[0] * 100000 +
            versionCells[1] * 1000 +
            versionCells[2];
      }

      int remoteVersion1 = getExtendedVersionNumber(remoteVersion);
      int minAppVersion1 = getExtendedVersionNumber(minAppVersion);
      int currentVersion1 = getExtendedVersionNumber(currentVersion);

      if (minAppVersion1 > currentVersion1) {
        _showAlert(
          context,
        );
      } else if (remoteVersion1 > currentVersion1) {
        _showUpdateAlert(
          context,
        );
      } else {
        print('App is up to date');
      }

      print('Remote version (extended): $remoteVersion1');
      print('Minimum app version (extended): $minAppVersion1');
      print('Current version (extended): $currentVersion1');
    }
    void _verifyMpin() async {
    if (verifyMpinKey.currentState!.validate()) {
      var sig=await SmsAutoFill().getAppSignature;
 print('Sinature$sig');
       String? token = await FirebaseHelper().getToken();
       print('fcm token-----$token');
        context
          .read<LoginMpinCubit>()
          .login(LoginMpinRequestModel( userId: sharedPreferenceHelper.getUserId,
          mpin: verifyMpinController.text,fcmToken: token ));
    }}
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Scaffold(
     
body:MultiBlocListener(
          listeners: [
            BlocListener<LoginMpinCubit, LoginMpinState>(
              listener: (context, state) {
                if (state.networkStatusEnum == NetworkStatusEnum.loaded &&
                    state.model.text == "Success") {
                
                 
                  ToastWidget(
                    message: state.model.message,
                    color: Colors.green,
                  ).build(context);
                context.router.replaceAll([BottomNavigationRoute()]);
                } else if (state.networkStatusEnum == NetworkStatusEnum.loaded &&
                    state.model.text != "Success") {
                      verifyMpinController.clear();
                  ToastWidget(message: state.model.message).build(context);
                }
              },
            ),
            BlocListener<ForgotMpinCubit, ForgotMpinState>(
              listener: (context,forgotMpinstate) {
                // Handle state changes from ForgotMpinCubit here
                if (forgotMpinstate.networkStatusEnum == NetworkStatusEnum.loaded &&
                    forgotMpinstate.model.text == "Success") {
                 
        context.router.push(OtpVerifyRoute(isForgotMpin:true,forgotMpinOtp:forgotMpinstate.model.otp.toString()));
                  ToastWidget(message:forgotMpinstate.model.message,color: Colors.green,).build(context);
                  // Navigate to appropriate screen or handle logic
                } else if (forgotMpinstate.networkStatusEnum == NetworkStatusEnum.loaded &&
                    forgotMpinstate.model.text != "Success") {
                  // Handle error scenario
                  ToastWidget(message:forgotMpinstate.model.message).build(context);
                  // Display error message or retry logic
                }
              },
            ),
          ],
     child:Padding(   
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key:verifyMpinKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LogoWidget(),
                const SizedBox(
                  height: 20,
                ),
              TextViewLarge(title: 'Login MPIN',textcolor: appColor,),
              const SizedBox(
                height: 20,
              ),
             Padding(
             padding:const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 60),
             child: PinCodeTextField(
               appContext: context,
               length: 4,
               obscureText: false,
               animationType: AnimationType.fade,
               pinTheme: PinTheme(
                 shape: PinCodeFieldShape.box,
                 borderRadius: BorderRadius.circular(5),
                 fieldHeight: 45,
                 fieldWidth: 45, // Adjusted for less space between fields
                 activeFillColor: Colors.white,
                 inactiveFillColor: Colors.white,
                 selectedFillColor: Colors.white,
                 
                activeColor:greyColor,
                 inactiveColor: greyColor,
                 selectedColor: appColor, // Focused border color
                 borderWidth: 0.5, 
             // Adjust border width if needed
               ),
               
               animationDuration: Duration(milliseconds: 300),
               keyboardType: TextInputType.number,
               enableActiveFill: true,
             
               controller: verifyMpinController,
               textStyle: TextStyle(fontSize: 12), // Reduced font size
               onCompleted: (v) {
                 print("Completed");
               },
               onChanged: (value) {
                 print(value);
                verifyMpinController.text=value;
                if(verifyMpinController.text.length==4){
                   _verifyMpin();
                }
               },
               beforeTextPaste: (text) {
                 print("Allowing to paste $text");
                 return true;
               },
             ),
           ),
              vericalSpaceSmall, 
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<ForgotMpinCubit,ForgotMpinState>(
                          builder: (context,state){
             if( state.networkStatusEnum==NetworkStatusEnum .loading){
              return CircularProgressIndicatorWidget();
             }       else{ return   TextButton(onPressed: (){
                      context
                              .read<ForgotMpinCubit>()
                              .login(UserIdRequestModel(userId: sharedPreferenceHelper.getUserId));
                              
                      
                    }, child: TextViewSmall(title: 'Forgot MPIN?',textcolor: appColor,));
  }}),
                ],
              ) ,     
             vericalSpaceMedium,
                         BlocBuilder<LoginMpinCubit,LoginMpinState>(
                          builder: (context,state){
             if( state.networkStatusEnum==NetworkStatusEnum .loading){
              return CircularProgressIndicatorWidget();
             }       else{ return  ButtonWidget(onPressed: (){
                                        _verifyMpin();
                                       }, buttonName: 'Verify MPIN', buttonColor:appColor);}
   } ),
              
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextViewSmall(title: "Don't have an account?",textcolor: appColor,),
                 TextButton(onPressed: (){
                   context.router.pushNamed(RouterPath.register_path);
                 }, child:TextViewSmall(title: 'Sign up',fontWeight: headingWeight,textcolor: appColor,))
               ],
             )
               
            ],
          ),
        ),
      )));
  }
   _launchURL(String url) async {
    final Uri urll = Uri.parse(url);
    if (await canLaunchUrl(urll)) {
      await launchUrl(urll);
    
     
      
    } else {
      throw 'Could not launch $urll';
    }
  }

   void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width *
                        1, // Adjust the width as needed
                    child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Ensure the dialog takes only as much space as needed
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/update.png',
                                ),
                                SizedBox(height: 16),
                                TextViewMedium(
                                    name:
                                        "You're using an older version of the app. Upgrade now to enjoy our latest improvements and bug fixes for a seamless save digital gold experience. It will only take a few moments!"),
                                vericalSpaceMedium,
                                ButtonWidget(
                                 buttonName: 'Upgrade Now',
                                  onPressed: () {
                                    _launchURL(
                                        'https://play.google.com/store/apps/details?id=com.kasgold.app');
                                  },
                                  buttonColor: appColor,
                                ),
                              ],
                            ),
                          )
                        ]))),
          );
        });
  }

  void _showUpdateAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width *
                      1, // Adjust the width as needed
                  child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Ensure the dialog takes only as much space as needed
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/update.png',
                              ),
                              SizedBox(height: 16),
                              TextViewMedium(
                                  name: 'Newer version is available!'),
                              vericalSpaceMedium,
                             Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonWidget(
                                    buttonName: 'Update Now',
                                    onPressed: () {
                                      _launchURL(
                                          'https://play.google.com/store/apps/details?id=com.kasgold.app');
                                    },
                                    buttonColor: appColor,
                                  ),
                                  vericalSpaceMedium,
                                  ButtonWidget(
                                   buttonName : '   Later   ',
                                    
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    buttonColor: whiteColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ])));
        });
  }

  }

   