import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my/src/repository/auth_repsitory/auth_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  /// TextField Validation

  // Call this Function from Design & it will do the rest
  // Future<void> login() async {
  //   String? error = await AuthenticationRepository.instance
  //       .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
  //   if (error != null) {
  //     Get.showSnackbar(GetSnackBar(
  //       message: error.toString(),
  //     ));
  //   }
  // }
  Future<void> login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(), password: password.text.trim());
  }

  // Future<void> login() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email.text.trim(),
  //       password: password.text.trim(),
  //     );
  //     // Successfully signed in, you can navigate to the desired screen
  //   } catch (e) {
  //     Get.showSnackbar(GetSnackBar(
  //       message: 'Error signing in: ${e.toString()}', // Show the error message
  //     ));
  //   }
  // }
}
