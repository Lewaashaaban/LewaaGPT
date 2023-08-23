import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my/src/Backend/models/userModel.dart';



// 2- create User repossitory 
class UserRespository extends GetxController {
  static UserRespository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection('Users')
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
            'Success', 'Your Account has been created',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, StackTrace) {
      Get.snackbar('Error', 'Something went wrong, try Again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }
}
