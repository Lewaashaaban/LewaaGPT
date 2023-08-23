import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my/src/Backend/models/userModel.dart';
import 'package:my/src/repository/auth_repsitory/auth_repository.dart';
import 'package:my/src/repository/user_repository/user_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // TextField Controllers to get data from TextFielnds
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRespository());

  void registerUser(String email, String password, String phone) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPasssword(email, password, phone);
  }

// Get phone number from user and passs it to the Auth Repository for firebase Authentication
  Future<void> CreateUser(UserModel user) async {
    await userRepo.createUser(user);
    phoneAuthentication(user.phoneNo);
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
