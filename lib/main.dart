import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my/firebase_options.dart';

import 'package:my/src/Backend/authentication/contollers/otp_controller.dart';
import 'package:my/src/Pages/LoginPage.dart';
import 'package:my/src/Pages/SignupPage.dart';
import 'package:my/src/Pages/chat/chatScreen.dart';
import 'package:my/src/Pages/forgot_password/fp_otp.dart';
// import 'package:my/src/Pages/homepage.dart';
import 'package:my/src/Pages/profile/profile_screen.dart';
import 'package:my/src/repository/auth_repsitory/auth_repository.dart';
import 'package:my/src/theme/theme.dart';

// import './src/features/authentication/Pages/settingsPage.dart';
import 'src/Pages/forgot_password/fp_mail.dart';
import 'src/Pages/forgot_password/fp_phone.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'src/Pages/welcomePage.dart';

void main() {
  // DotEnv env = DotEnv()..load(.env); // Loads our .env file.
  // OpenAI.apiKey =
  //     env['OPEN_AI_API_KEY']; // Initialize the package with that API key

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
      initialRoute: '/chat',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginPage(),
        '/forgotPassword/mail': (context) => ForgetPasswordMailScreen(),
        '/forgotPassword/phone': (context) => ForgotPasswordPhoneScreen(),
        '/forgotPassword/otp': (context) => OTPscreen(),
        '/chat': (context) => ChatScreen(),
        '/signup': (context) => SignupPage(),
        // '/settings': (context) => SettingsPage(),
        '/profile': (context) => ProfileScreen(),
      },
    );
    //     },
    //   ),
    // );
  }
}
