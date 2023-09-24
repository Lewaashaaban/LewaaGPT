// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my/firebase_options.dart';
import 'package:my/src/Backend/authentication/contollers/otp_controller.dart';
import 'package:my/src/Pages/LoginPage.dart';
import 'package:my/src/Pages/SignupPage.dart';
import 'package:my/src/Pages/chat/chatscreen2.dart';
import 'package:my/src/Pages/profile/profile_screen.dart';
import 'package:my/src/Pages/profile/userInfo/userInfo.dart';
import 'package:my/src/repository/auth_repsitory/auth_repository.dart';
import 'package:my/src/theme/theme.dart';
import 'src/Pages/forgot_password/fp_mail.dart';
import 'src/Pages/forgot_password/fp_phone.dart';

import 'src/Pages/welcomePage.dart';

void main() {
  WidgetsFlutterBinding();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthenticationRepository());
    Get.put(OTPController()); // Register the OTPController instance
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AMBOT',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darktheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginPage(),
        '/forgotPassword/mail': (context) => ForgetPasswordMailScreen(),
        '/forgotPassword/phone': (context) => ForgotPasswordPhoneScreen(),
        '/chat': (context) => ChatPage(),
        '/signup': (context) => SignupPage(),
        '/profile': (context) => ProfileScreen(),
        '/profile/info': (context) => UserInfo(),
      },
    );
    //     },
    //   ),
    // );
  }
}
