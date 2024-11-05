import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kascollection/router/app_router.dart';
import 'package:kascollection/utils/apiservice/api_service.dart';
import 'package:kascollection/utils/auth_repository.dart';
import 'package:kascollection/utils/constant.dart';
import 'package:kascollection/utils/constants/api_constants.dart';
import 'package:kascollection/utils/constants/sharedpreference_help.dart';
import 'package:kascollection/utils/firebase_helper.dart';
import 'package:kascollection/utils/my_observer.dart';
import 'package:kascollection/widgets/logger_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  firebaseHelper = FirebaseHelper();
  await firebaseHelper?.setupFlutterNotifications(); // Ensure notifications are set up

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Listen to messages when app is in foreground
  FirebaseMessaging.onMessage.listen(firebaseHelper?.showFlutterNotification);

  await firebaseHelper?.crashReport();

  runApp(MyApp());
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  firebaseHelper?.showFlutterNotification(message); // Show the notification
}

FirebaseHelper? firebaseHelper;
class MyApp extends StatelessWidget {
 MyApp({super.key});
 final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
     final SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

    // Configure Dio
    final Dio dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: true,
      validateStatus: (_) => true,
      headers: {
        "Accept": "application/json",
      },
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
    ));

    // Add interceptors if needed
    dio.interceptors.add(LoggerInterceptor());

    // Create ApiService instance
    final ApiService apiService = ApiService(dio,sharedPreferenceHelper);

    // Create AuthRepository instance
    final AuthRepository authRepository = AuthRepository(apiService);

    // Create SiteSetting
   
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(apiService),
        ),
        
        // RepositoryProvider<SiteSettingsRepository>(
        //   create: (context) => SiteSettingsRepository(),
        // ),
        ],
        child:MultiBlocProvider(
        providers: [
          BlocProvider<RegisterCubit>(
            create: (repoContext) => RegisterCubit(authRepository:AuthRepository(apiService))),
           
        
          ],

   child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: MaterialApp.router(
                routerConfig: _appRouter.config(
                  navigatorObservers: () => [MyObserver()],
                ),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: whiteColor),
                  useMaterial3: true,
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(
                      color: whiteColor,
                    ),
                  ),
                  fontFamily: 'Montserrat',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}