// ignore_for_file: prefer_const_constructors, avoid_print, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:my/src/Backend/contollers/deleteUserData.dart';
import 'package:my/src/Backend/contollers/getUserData.dart';
import 'package:my/src/Backend/contollers/updateUserData.dart';
import 'package:my/src/Pages/welcomePage.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/imageStrings.dart';
import 'package:my/src/constants/sizes.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String? imageUrl;
  String? selectedImagePath;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchImageUrl();
  }

  Map<String, dynamic>? userData;
  String? errorMessage;
  DateTime? creationTime;
  late Future<Map<String, dynamic>> userDataFuture;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

// Updated _updateImageUrl function
  Future<void> _updateImageUrl(String url) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'ImageUrl': url,
        });
        setState(() {
          imageUrl = url; // Update the local imageUrl as well
        });
      } catch (error) {
        print('Error updating imageUrl in Firestore: $error');
      }
    }
  }

// fxn to fetch the imageUrl from Firestore
  Future<void> fetchImageUrl() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDataSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        if (userDataSnapshot.exists) {
          final data = userDataSnapshot.data() as Map<String, dynamic>;
          final imageUrl = data['ImageUrl'];
          setState(() {
            this.imageUrl = imageUrl;
          });
        }
      } catch (error) {
        print('Error fetching imageUrl from Firestore: $error');
      }
    }
  }

// fxn to get user data
  Future<void> fetchUserData() async {
    userDataFuture = getUserDataForCurrentUser(); // Assign the Future here
    final userDataAndCreationTimeResult = await userDataFuture;

    setState(() {
      errorMessage = userDataAndCreationTimeResult['errorMessage'];
      if (errorMessage == null) {
        userData = userDataAndCreationTimeResult['userData'];
        creationTime = userDataAndCreationTimeResult['creationTime'];
      }
    });
  }

// fxn to update userdata
  Future<void> updateUserData() async {
    final updatedFullName = _fullNameController.text;
    final updatedEmail = _emailController.text;
    final updatedPhone = _phoneController.text;
    final updatedPassword = _passwordController.text;

    // Fetch the current user data
    final currentUserData =
        userData; // Replace with the actual way you fetch the user data

    try {
      // Only update fields that are not empty
      if (updatedFullName.isNotEmpty) {
        currentUserData!['FullName'] = updatedFullName;
      }
      if (updatedEmail.isNotEmpty) {
        currentUserData!['Email'] = updatedEmail;
      }
      if (updatedPhone.isNotEmpty) {
        currentUserData!['Phone'] = updatedPhone;
      }
      if (updatedPassword.isNotEmpty) {
        currentUserData!['Password'] = updatedPassword;
      }

      // Update the profile with the modified data
      await updateProfile(
        fullName: currentUserData!['FullName'],
        email: currentUserData['Email'],
        phone: currentUserData['Phone'],
        password: currentUserData['Password'],
      );

      Get.snackbar('Success', 'Profile updated successfully');
      Get.back();
    } catch (error) {
      Get.snackbar('Error', 'An error occurred while updating profile');
    }
  }

// fxn to delete user
  Future<void> logOutAndShowConfirmation() async {
    var response = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Confirm Account Deletion'),
        content: Text('Are you sure you want to delete your account?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false), // Cancel button
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true), // Delete button
            child: Text('Delete'),
          ),
        ],
      ),
    );
    if (response != null && response) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.delete();
          final userId = user.uid;
          await deleteUserData(userId);
          Get.offAll(() => WelcomeScreen());
          Get.snackbar(
              'Success', 'User deleted successfully. You are logged out');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred while deleting your account.');
      }
    }
  }

// fex to get image from gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload the selected image to Firebase Storage
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final storageRef =
            FirebaseStorage.instance.ref().child('profile_images/${user.uid}');
        final uploadTask = storageRef.putFile(File(pickedFile.path));

        await uploadTask.whenComplete(() async {
          String imageUrl = await storageRef.getDownloadURL();
          // Update the image URL in Firestore and locally
          await _updateImageUrl(imageUrl);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // User? currentUser = FirebaseAuth.instance.currentUser;

    // final controller = Get.put(ProfileController());s
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Update Profile',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              // -- IMAGE with ICON
              // https://firebasestorage.googleapis.com/v0/b/my-project-31c01.appspot.com/o/user_images%2FzBKHSxwMzlR0SnnNg4LGj6rDwZs1.jpg?alt=media&token=bc04c290-7d5c-4369-9bd6-04f5b5cd2c2d
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      // ignore: unnecessary_null_comparison
                      child: imageUrl != null && imageUrl!.isNotEmpty
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              tUSerIamge), // Display a default image if imageUrl is empty
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: tPrimaryColor),
                        child: const Icon(LineAwesomeIcons.camera,
                            color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    FutureBuilder<Map<String, dynamic>>(
                      future: userDataFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Show a loading indicator
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final userData = snapshot.data!['userData'];
                          return Column(
                            children: [
                              // name textfield
                              TextFormField(
                                controller: _fullNameController,
                                decoration: InputDecoration(
                                  labelText: userData != null
                                      ? '${userData['FullName']}'
                                      : '',
                                  prefixIcon: Icon(LineAwesomeIcons.user),
                                ),
                              ),
                              SizedBox(height: tFormHeight - 15),

                              // email textfield
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: userData != null
                                      ? '${userData['Email']}'
                                      : '',
                                  prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                                ),
                              ),
                              SizedBox(height: tFormHeight - 15),

                              // phone textfield
                              TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  labelText: userData != null
                                      ? '${userData['Phone']}'
                                      : '',
                                  prefixIcon: Icon(LineAwesomeIcons.phone),
                                ),
                              ),
                              SizedBox(height: tFormHeight - 15),

                              // pasword textfield
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: userData != null
                                      ? '${userData['Password']}'
                                      : '',
                                  prefixIcon: const Icon(Icons.fingerprint),
                                  suffixIcon: IconButton(
                                      icon: const Icon(
                                          LineAwesomeIcons.eye_slash),
                                      onPressed: () {}),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: tFormHeight),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          updateUserData();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Update Profile',
                            style: TextStyle(color: tDarkColor)),
                      ),
                    ),
                    const SizedBox(height: tFormHeight),

                    // -- Created Date and Delete Button
                    Column(
                      children: [
                        if (creationTime != null)
                          Text(
                            "Account created on: ${DateFormat('yyyy-MM-dd HH:mm:ss \n').format(creationTime!)}",
                          ),
                        ElevatedButton(
                          onPressed: () {
                            logOutAndShowConfirmation();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text('Delete Account'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
