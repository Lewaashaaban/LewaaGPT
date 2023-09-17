import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:my/src/Backend/contollers/deleteUserData.dart';
import 'package:my/src/Backend/contollers/getUserData.dart';
import 'package:my/src/Backend/contollers/imageController.dart';
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
  }

//  Function to Get the user data
  Map<String, dynamic>? userData;
  String? errorMessage;
  DateTime? creationTime;
  late Future<Map<String, dynamic>> userDataFuture;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // fxn to get usser data
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

    try {
      await updateProfile(
        fullName: updatedFullName,
        email: updatedEmail,
        phone: updatedPhone,
        password: updatedPassword,
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

// fxn to open image picker
  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     File selectedImage = File(pickedFile.path);

  //     // Upload the selected image to Firebase Storage
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       // final storageRef =
  //       //     FirebaseStorage.instance.ref().child('profile_images/${user.uid}');
  //       final storageRef = await FirebaseFirestore.instance.collection('Users').add({

  //       });
  //       final uploadTask = storageRef.putFile(selectedImage);

  //       await uploadTask.whenComplete(() async {
  //         final imageUrl = await storageRef.getDownloadURL();

  //         // Update the image URL in the user's Firestore document
  //         try {
  //           final userDocRef =
  //               FirebaseFirestore.instance.collection('users').doc(user.uid);
  //           await userDocRef.update({'imageUrl': imageUrl});
  //         } catch (error) {
  //           print('Error updating user profile image: $error');
  //         }

  //         // Update the local state with the image URL
  //         setState(() {
  //           selectedImagePath = imageUrl;
  //         });
  //       });
  //     }
  //   }
  // }

  // fxn to update image url
  // Future<void> _updateImageUrl(String imageUrl) async {
  //   final CollectionReference usersCollectionReference =
  //       FirebaseFirestore.instance.collection('Users');
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       // Update the image URL in the Firestore document for the user
  //       // Replace 'usersCollectionReference' with your actual Firestore collection reference
  //       final userDocRef = usersCollectionReference.doc(user.uid);
  //       await userDocRef.update({'ImageUrl': imageUrl});
  //     }
  //   } catch (error) {
  //     // Handle any errors that occur during the update
  //     print('Error updating image URL: $error');
  //   }
  // }
  // Function to upload the image to Firebase Storage
  // Function to fetch the user's image URL from Firestore
  Future<void> fetchUserImage() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Get the user's UID
      String userId = currentUser.uid;

      try {
        // Check if the user document exists
        final userDocRef =
            FirebaseFirestore.instance.collection('Users').doc(userId);
        final userDoc = await userDocRef.get();

        if (userDoc.exists) {
          // Check if 'ImageUrl' field exists
          if (userDoc.data() != null && userDoc.data()!['ImageUrl'] != null) {
            // Get the image URL from Firestore
            setState(() {
              imageUrl = userDoc.data()!['ImageUrl'];
            });
          }
        } else {
          print('User document not found.');
        }
      } catch (e) {
        print('Error fetching user image: $e');
      }
    }
  }

  Future<void> handleImageSelection(User? currentUser) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Get the local path of the selected image
        String imagePath = pickedFile.path;

        // Call the function to upload the image and update/add to Firestore
        await updateOrAddUserImage(imagePath);

        // Fetch the user's image URL from Firestore after it's updated
        await fetchUserImage();

        // Optionally, show a success message or update the UI
        // indicating that the image has been successfully updated.
      } else {
        // Handle the case where the user canceled image selection.
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      print('Error handling image selection: $e');
      // Optionally, show an error message or update the UI to indicate the error.
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    String? selectedImagePath;
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
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        // ignore: unnecessary_null_comparison
                        child: selectedImagePath != null
                            ? Image.file(File(selectedImagePath))
                            : Image.asset(tUSerIamge)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        handleImageSelection(currentUser);
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
