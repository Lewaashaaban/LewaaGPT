import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my/src/Backend/models/userModel.dart';
// import 'package:my/src/Backend/models/userModel.dart';
// import 'package:my/src/repository/auth_repsitory/auth_repository.dart';
import 'package:my/src/repository/user_repository/user_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // TextField Controllers to get data from TextFielnds
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRespository());

  // Future signup() async {
  //   FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     email: email.text.trim(),
  //     password: password.text.trim(),
  //   );
  // }
  Future signup() async {
    try {
      final userModel = UserModel(
        email: email.text.trim(),
        fullName: fullName.text.trim(),
        phoneNo: phoneNo.text.trim(),
        passsword: password.text.trim(),
      );

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password.text.trim(),
      );
      // After creating the user, save additional information in Firestore
      await userRepo.createUser(userModel);
    } catch (e) {
      print('Error signing up: $e');
    }
  }
}



// Get phone number from user and pass it to the Auth Repository for firebase Authentication
//   Future<void> CreateUser(UserModel user) async {
//     await userRepo.createUser(user);
//     phoneAuthentication(user.phoneNo);
//   }

//   void phoneAuthentication(String phoneNo) {
//     AuthenticationRepository.instance.phoneAuthentication(phoneNo);
//   }
// }
