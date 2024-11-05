

import 'dart:developer';


import 'package:kascollection/utils/constants/sharedpreference_help.dart';


class ApiConstant{
  static String get siteUrl {
    final sharedPreferenceHelper = SharedPreferenceHelper();
    return sharedPreferenceHelper.getSiturl;
  }
static String get logoUrl {
    final sharedPreferenceHelper = SharedPreferenceHelper();
    return "${sharedPreferenceHelper.getLogo}";
  }
static String get homeLogoUrl {
    final sharedPreferenceHelper = SharedPreferenceHelper();
    return "${sharedPreferenceHelper.getHomeLogo}";
  }
  static String get langCode {
    final sharedPreferenceHelper = SharedPreferenceHelper();
    return sharedPreferenceHelper.getLanguageCode;
  }
  static String get userId{
    final prefs =SharedPreferenceHelper();
   return prefs.getUserId;
  }
  static String get photo{
    final prefs =SharedPreferenceHelper();
   return prefs.getPhoto;
  }
  static String get delContent{
    final prefs =SharedPreferenceHelper();
   return prefs.getDelContent;
  }
  static String get delreq{
    final prefs =SharedPreferenceHelper();
   return prefs.getDelReq;
  }
  static String baseUrl = "https://kasjewellery.in/";
 static const String token="app-generate-token";
 
 static const String userRegister= "app-register";
 
 static const String userResend='app-resend-otp';
static const String userRegisterMpin ='app-login-create-mpin';
static const String userLogin='app-login';
static const String userLoginMpin ='app-login-mpin';
static const String userTerms='app-terms-conditions';
static const String userPrivacy='app-privacy-policy';
static const String userForgotMpin='app-forgot-mpin';
static const String userResetMpin='app-reset-mpin';
static const String userLanguagesList='app-languages';
static const String userHome='app-home-page';
static const String userStepper='app-customer-form';
static const String userStepperForm='app-insert-customer-form';
static const String userContact='app-contact-details';
static const String userSubmitEnquiry='app-submit-enquiry';
static const String userViewProfile='app-view-profile';
static const String userGallery='app-images-gallery';
static const String userPlans='app-plans';
static const String userAboutUs='app-about-us';
static const String userPlanTypes='app-plan-type';
static const String userNotification='app-notifications';
static const String userVideo='app-videos-gallery';

static const String userPlanDetail='app-plan-details';
  static const String siteSettings =  "app-site-settings";

 static const String userRegisterConfirmOtp='app-register-otp-confirm';
static const String userUtubeChannel='app-youtube-channel';

static const String userTrainingBook='app-training-book';

static const String userReports='app-reports';
static const String userDelete='app-deactivate-account';
static const String homeUrl='app-home-page';
static const String siteLanguages='app-languages';
static const String userCountriesList='countries-list';
static const String userStores='app-stores';
static const String userStoreDetail='app-store-detail';
static const String userPincode='app-get-location-pincode';
static const String userEarnings='app-earnings';
static const String userTrans='app-transactions';
static const String userMonthPlans='app-month-plans';
static const String userLucky='app-lucky-draw';
static const String userMobileCheck='app-check-customer-exists';
static const String userWp='app-check-customer-whatsapp-exists';
static const String userGift='app-customer-form-gift';
static const String userReceipt='app-customer-form-receipt-link';
static const String userGiftDelivery='app-update-customer-form-gift';
static const String userInvite='app-invite-friends';
static const String userChangeMpin='app-change-mpin';
static const String userChangeMpinData='app-change-mpin-data';
static const String userDailyReport='app-daily-reports';
static const String userEvent='app-user-event-list';
static const String userAddEvent='app-user-add-event';
static const String userDeleteEvent='app-user-cancel-event';
static const String userUpdateEvent='app-user-update-event';
  }
  