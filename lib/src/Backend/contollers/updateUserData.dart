import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

Future<void> updateProfile({
  required String fullName,
  required String email,
  required String phone,
  required String password,
}) async {
  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    // Update the user's data in Firestore
    if (uid != null) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance.collection('Users').doc(uid).update({
        'FullName': fullName,
        'Email': email,
        'Phone': phone,
        'Password': password,
        // Update other fields if needed
      });
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      await FirebaseAuth.instance.currentUser?.updatePassword(password);
      // Show a success message or navigate back
      Get.snackbar('Success', 'Profile updated successfully');
      // You can navigate back after updating
      Get.back();
    }
  } catch (error) {
    // Handle the error appropriately
    Get.snackbar('Error', 'An error occurred while updating profile');
  }
}
