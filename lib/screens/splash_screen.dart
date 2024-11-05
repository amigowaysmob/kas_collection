import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kascollection/cubits/site_settings_cubit.dart';
import 'package:kascollection/router/app_router.gr.dart';
import 'package:kascollection/router/router_path.dart';
import 'package:kascollection/screens/no_internet_screen.dart';
import 'package:kascollection/states/site_settings_state.dart';
import 'package:kascollection/utils/constants/api_constants.dart';
import 'package:kascollection/utils/constants/sharedpreference_help.dart';
import 'package:kascollection/utils/enums.dart';
import 'package:kascollection/utils/firebase_helper.dart';
import 'package:kascollection/widgets/indicator_widget.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferenceHelper sharedPreferenceHelper;
  var isNavigate=true;
  @override
  
  
   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
   void initState() {
    super.initState();
      // WidgetsBinding.instance.addObserver();
    checkForUnreadNotifications();
print('checking');
    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialization settings for both platforms
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // iOS initialization
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload.toString().isNotEmpty) {
         context.router.push(NotificationScreen());
        }
      },
    );
    initializeSharedPrefs();
  }
 void dispose() {
    // WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkForUnreadNotifications();
    }
  }
   Future<void> checkForUnreadNotifications() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (Platform.isIOS) {
       

        context.router.push(NotificationScreen(
           ));
      }
       if (Platform.isAndroid) {
       
print('android');
        context.router.push(NotificationScreen(
           ));
      }
    });

    var notificationValue =
        await FirebaseHelper().checkForUnOpenedNotifications();

    if (notificationValue != null) {
      context.router.push(NotificationScreen(
           ));
    }
  }
  void initializeSharedPrefs() async {
    sharedPreferenceHelper = SharedPreferenceHelper();
    await sharedPreferenceHelper.init();
    // context.read<TokenCubit>().login(); 
    // context.read<SiteSettingsCubit>().login(); 
   
  }
  _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 6)); // Simulate splash screen delay
    // final userBox = await Hive.openBox<bool>('userBox');
    // bool? isLoggedIn = userBox.get('isLoggedIn', defaultValue: false);
    // if (isLoggedIn!) {
      // Navigator.pushReplacementNamed(
      //     context, '/bottomNavigation'); // Navigate to BottomNavigationPage if logged in
    // } 
    // else {
    print('id----${sharedPreferenceHelper.getUserId}');
    print('mpin status-----${sharedPreferenceHelper.getMpinStatus}');
    if(sharedPreferenceHelper.getUserId!=null && sharedPreferenceHelper.getUserId.isNotEmpty && sharedPreferenceHelper.getMpinStatus=='1'){
  context.router.replaceNamed(RouterPath.verify_mpin_path);
 }
 else if(sharedPreferenceHelper.getUserId!=null && sharedPreferenceHelper.getUserId.isNotEmpty && sharedPreferenceHelper.getMpinStatus!='1'){
  context.router.replaceNamed(RouterPath.login_path);
 }

          else{
           context.router.replaceNamed(RouterPath.register_path); // Navigate to LoginPage if not logged in
    // }
          }}

  @override
 

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SiteSettingsCubit, SiteSettingsState>(
        builder: (context, state) {
      print(state.networkStatusEnum);
      if (state.networkStatusEnum == NetworkStatusEnum.loading ||state.networkStatusEnum == NetworkStatusEnum.initial) {
        return CircularProgressIndicatorWidget();
      }
      if (state.networkStatusEnum == NetworkStatusEnum.loaded) {
         _navigateToNextPage();
        final siteSettings = state.model;

sharedPreferenceHelper.saveLogo(siteSettings.data?[0].logoImage);
sharedPreferenceHelper.saveHomeLogo(siteSettings.data?[0].headerLogo);
sharedPreferenceHelper.saveSiteurl(siteSettings.data?[0].siteUrl);
sharedPreferenceHelper.saveDelContent(siteSettings.data?[0].deleteAccountContent);
sharedPreferenceHelper.saveDelReq(siteSettings.data?[0].deleteAccountAlertContent);
print('logourl-------${ApiConstant.logoUrl}');
        final logoImageUrl = ApiConstant.logoUrl;

        return Scaffold(
         
          body: Center(
            child: Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                width: 200,
                
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(logoImageUrl),
                    fit: BoxFit.fill,
                    onError: (exception, stackTrace) {
                      // Handle error during image loading
                      print('Error loading image: $exception');
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        
           
        
       
        return NoInternetScreen();
      }
    });
  }
}
