import 'package:dio/dio.dart';
import 'package:kascollection/response_model/forgot_mpin_model.dart';
import 'package:kascollection/response_model/login_model.dart';
import 'package:kascollection/response_model/login_mpin_model.dart';
import 'package:kascollection/response_model/site_settings_model.dart';
import 'package:kascollection/utils/apiservice/api_service.dart';
import 'package:kascollection/utils/constants/api_constants.dart';
import 'package:kascollection/utils/constants/sharedpreference_help.dart';

class AuthRepository {
  final Dio _dio = Dio();
final ApiService apiService;
 SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  AuthRepository(this.apiService);
  Future<dynamic> userSiteSettings()async{
 try {
 
      var response = await apiService.post(ApiConstant.siteSettings,{});
       if (response.statusCode == 200 ) {
        var responseData = response.data;
        return (true,SiteSettingsModel.fromJson(responseData));
       }
       else {
        // Handle other status codes
        print('Unexpected status code: ${response.statusCode}');
        return (false, SiteSettingsModel());
      }
    } catch (e,stacktrace) {
      print('Exception occurred: $e');
      print('Stacktrace${stacktrace}');
      return (false, SiteSettingsModel());
    }
    } 
     Future<dynamic> userLogin(LoginRequestModel loginRequestModel)async{
 try {
 
      var response = await apiService.post(ApiConstant.userLogin,loginRequestModel);
       if (response.statusCode == 200 ) {
        var responseData = response.data;
        return (true,LoginModel.fromJson(responseData));
       }
       else {
        // Handle other status codes
        print('Unexpected status code: ${response.statusCode}');
        return (false, LoginModel());
      }
    } catch (e,stacktrace) {
      print('Exception occurred: $e');
      print('Stacktrace${stacktrace}');
      return (false, LoginModel());
    }
    } 
     Future<dynamic> userForgotMpin(UserIdRequestModel UserIdRequestModel)async{
 try {
 
      var response = await apiService.post(ApiConstant.userForgotMpin,UserIdRequestModel);
       if (response.statusCode == 200 ) {
        var responseData = response.data;
        return (true,ForgotMpinModel.fromJson(responseData));
       }
       else {
        // Handle other status codes
        print('Unexpected status code: ${response.statusCode}');
        return (false, ForgotMpinModel());
      }
    } catch (e,stacktrace) {
      print('Exception occurred: $e');
      print('Stacktrace${stacktrace}');
      return (false, ForgotMpinModel());
    }
    } 
     Future<dynamic> userLoginMpin(LoginMpinRequestModel loginMpinRequestModel)async{
 try {
 
      var response = await apiService.post(ApiConstant.userLoginMpin,loginMpinRequestModel);
       if (response.statusCode == 200 ) {
        var responseData = response.data;
        return (true,LoginMpinModel.fromJson(responseData));
       }
       else {
        // Handle other status codes
        print('Unexpected status code: ${response.statusCode}');
        return (false, LoginMpinModel());
      }
    } catch (e,stacktrace) {
      print('Exception occurred: $e');
      print('Stacktrace${stacktrace}');
      return (false, LoginMpinModel());
    }
    }  
}