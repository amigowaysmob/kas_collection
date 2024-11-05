import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kascollection/router/router_path.dart';
import 'package:kascollection/utils/constant.dart';
import 'package:kascollection/utils/enums.dart';
import 'package:kascollection/widgets/logo_widget.dart';
import 'package:kascollection/widgets/text_form_widget.dart';
import 'package:kascollection/widgets/text_view_small.dart';
import 'package:kascollection/widgets/toast_widget.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  // const ForgotPasswordPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController forgotConPassController = TextEditingController();
  TextEditingController phoneNumberController=TextEditingController();
 TextEditingController referbyController=TextEditingController();
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _validateUsername(String? value) {
   
    if (value!=null&& value.isNotEmpty&& !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  }
String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'please enter Name';
    }
}
String? _checkbox(bool? _isChecked) {
  if(_isChecked==false){
    return 'Please agree to the Terms and Conditions';
  }
   return null;
}
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{6,}$').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter and one number';
    }
    return null;
  }

  // String? _validateConfirmPassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a password';
  //   }
  //   if (value.length < 6) {
  //     return 'Password must be at least 6 characters';
  //   }
  //   if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{6,}$').hasMatch(value)) {
  //     return 'Password must contain at least one uppercase letter and one number';
  //   }
  //   if (value != forgotpasswordController.text) {
  //     return 'Passwords do not match';
  //   }
  //   return null;
  // }
String? _validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    }
     else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }
  void register() async {
    
    if (registerKey.currentState!.validate()&& _isChecked ) {
     
     
      context
          .read<RegisterCubit>()
          .login(RegisterRequestModel(email: emailController.text,fullName: nameController.text,phoneNumber: phoneNumberController.text));
    }
    else if(_isChecked!=true){
      ToastWidget(message: 'Please agree to the terms and conditions',).build(context);
    }
  }
 bool _isChecked = false;

  void _onTermsOfUseTap() {
    context.router.pushNamed(RouterPath.terms_path);
  }

  void _onPrivacyPolicyTap() {
   
   context.router.pushNamed(RouterPath.privacy_path);
  }
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Scaffold(
      
        body:   BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
           
      if (state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text=='Success') {
     ToastWidget(message: state.model.message,color: Colors.green,
        ).build(context);
         context.router.push(OtpVerifyRoute(  registerOtp: state.model.data.toString(),
         phoneNumber:phoneNumberController.text,
                  conRegisterRequestModel: ConRegisterRequestModel(
                   email: emailController.text,
                   fullName: nameController.text,
                   phoneNumber: phoneNumberController.text,
                   referBy: referbyController.text
                  ),));
      }
      else if(state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text!='Success'){
 ToastWidget(message: state.model.message).build(context);
        
      }
    },
     builder: (context, state) {
     return SafeArea(
       child: SingleChildScrollView(
         child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: registerKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  vericalSpaceLarge,
                  LogoWidget(),
                vericalSpaceLarge,
                  
                
                vericalSpaceLarge,
                  TextForm(
                    controller:nameController,
                    keyboardType: TextInputType.text,
                    labelText: 'Name*',
                    hintText: 'Enter Your name*',
                    validating: _validateName,
                  ),
                vericalSpaceLarge,
                 
                  TextForm(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    labelText: 'Phone Number*',
                    hintText: 'Enter Phone Number*',
                    validating: _validatePhoneNumber,
                    type:'mobileNumber'
                  ),
                  vericalSpaceLarge,
                    TextForm(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    hintText: 'Enter email',
                     validating: _validateUsername,
                  ),
                vericalSpaceLarge,
                   TextForm(
                    controller: referbyController,
                    keyboardType: TextInputType.text,
                    labelText: 'Referral code',
                    hintText: 'Enter Referral code',
                    
                  ),
                vericalSpaceMedium,
                  // state.networkStatusEnum==NetworkStatusEnum.loading?CircularProgressIndicator(color: appColor,):
                  // ButtonWidget(
                  //     onPressed: () {
                  //       //  FocusScope.of(context).unfocus();
                  //     //  register();
                        
                  //     },
                  //     buttonName: 'Send OTP',
                  //     buttonColor: appColor,),
                   Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
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
                ),vericalSpaceMedium,
 state.networkStatusEnum==NetworkStatusEnum.loading?CircularProgressIndicatorWidget():                InkWell(
           onTap:register,
          child: Container(
            height: sheight / 19,
            width: swidth /1.1,
            decoration: BoxDecoration(
              color: appColor,
              border: Border.all(color: whiteColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
               'Register',
                style:  TextStyle(
                  color: whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
             ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    TextViewSmall(title: 'Already have an account?',textcolor: appColor,),
                    TextButton(onPressed: (){
          context.router.pushNamed(RouterPath.login_path);
                    }, child: TextViewSmall(title: 'Sign in',fontWeight: FontWeight.bold,textcolor: appColor,))
                  ],)
         
                   
                ],
              ),
            ),
          ),
       ),
     );
   } ));
  }
}
