// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my/src/Backend/models/userModel.dart';

import 'package:my/src/repository/user_repository/user_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final signupSuccess = false.obs; // Add an observable flag

  // TextField Controllers to get data from TextFielnds
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRespository());

  Future<void> signup(BuildContext context) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      // final uid = FirebaseAuth.instance.currentUser?.uid;
      final userModel = UserModel(
        id: userCredential.user?.uid,
        email: email.text.trim(),
        fullName: fullName.text.trim(),
        phoneNo: phoneNo.text.trim(),
        passsword: password.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userModel.id) // Use the UID as the document ID
          .set(userModel.toJson()); // Store the user data in the document
      // Set the signupSuccess flag to true
      signupSuccess.value = true;

      // Only navigate to /chat if signup was successful
      if (signupSuccess.value) {
        Navigator.pushNamed(context, '/chat');
      }
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }
}

//   Future<void> signup(BuildContext context) async {
//     try {
//       // Create the user in Firebase Authentication
//       final userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email.text.trim(),
//         password: password.text.trim(),
//       );

//       // Get the UID of the newly created user
//       final uid = userCredential.user?.uid;

//       // Create a new user document in Firestore
//       await FirebaseFirestore.instance.collection('Users').doc(uid).set({
//         'FullName': fullName.text.trim(),
//         'Email': email,
//         'Phone': phoneNo,
//         // Add any other user data you want to store
//       });
//       // Registration successful
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             content: Text('Registration successful!'),
//           );
//         },
//       );
//     } on FirebaseAuthException catch (e) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             content: Text(e.message.toString()),
//           );
//         },
//       );
//     }
//   }
// }




// Get phone number from user and pass it to the Auth Repository for firebase Authentication
//   Future<void> CreateUser(UserModel user) async {
//     await userRepo.createUser(user);
//     phoneAuthentication(user.phoneNo);
//   }

//   void phoneAuthentication(String phoneNo) {
//     AuthenticationRepository.instance.phoneAuthentication(phoneNo);
//   }
// }
