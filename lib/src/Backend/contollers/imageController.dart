import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

// Function to upload the image to Firebase Storage
Future<String?> uploadImageToFirebaseStorage(
    String userId, String imagePath) async {
  try {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('$userId.jpg');
    print(userId);
    final uploadTask = ref.putFile(File(imagePath));
    final TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => print('Image uploaded'));

    if (taskSnapshot.state == TaskState.success) {
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } else {
      print('Image upload failed');
      return null;
    }
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

// Function to update or add the image URL for the current user in Firestore
Future<void> updateOrAddUserImage(String imagePath) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  try {
    if (currentUser != null) {
      // Get the user's UID
      String userId = currentUser.uid;

      // Check if the user document exists
      final userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);
      final userDoc = await userDocRef.get();

      if (userDoc.exists) {
        // User document exists, check if 'ImageUrl' field exists
        if (userDoc.data() != null && userDoc.data()!['ImageUrl'] != null) {
          // User already has an image, update it
          final imageUrl =
              await uploadImageToFirebaseStorage(userId, imagePath);
          await userDocRef.update({'ImageUrl': imageUrl});
        } else {
          // User doesn't have an image, add a new image URL
          final imageUrl =
              await uploadImageToFirebaseStorage(userId, imagePath);
          await userDocRef.set({'ImageUrl': imageUrl}, SetOptions(merge: true));
        }
      } else {
        print('User document not found.');
      }
    } else {
      print('No user is authenticated.');
    }
  } catch (e) {
    print('Error updating or adding user image: $e');
  }
}
