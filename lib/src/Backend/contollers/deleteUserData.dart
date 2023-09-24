// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> deleteUserData(String userId) async {
  await FirebaseFirestore.instance.collection('Users').doc(userId).delete();
}