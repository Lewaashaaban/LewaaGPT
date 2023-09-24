// ignore_for_file: annotate_overrides, avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:my/src/Backend/contollers/getUserData.dart';
import 'package:my/src/Pages/profile/Payment.dart';
import 'package:my/src/Pages/profile/update_profile_screen.dart';
import 'package:my/src/Pages/profile/widgets/profile_menu.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/imageStrings.dart';
import 'package:my/src/constants/sizes.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchImageUrl();
  }

  List<String> docIDs = [];
  Map<String, dynamic>? userData;
  String? errorMessage;

  DateTime? creationTime;
  late Future<Map<String, dynamic>> userDataFuture; // Declare the Future

// fxn to fetch userdata
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

// frn to logout
  Future<void> logOut() async {
    var response = await Get.dialog<bool>(
      AlertDialog(
        iconColor: tPrimaryColor,
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false), // Cancel button
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true), // Delete button
            child: Text('Logout'),
          ),
        ],
      ),
    );

    if (response != null && response) {
      Get.offAllNamed('/');
    }
  }

  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: tWhiteColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: imageUrl != null && imageUrl!.isNotEmpty
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              tUSerIamge), // Display a default image if imageUrl is empty
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),

              // const SizedBox(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (errorMessage != null)
                      Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    if (userData != null)

                      // Use FutureBuilder for displaying user data
                      FutureBuilder<Map<String, dynamic>>(
                          future: userDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final userData = snapshot.data!['userData'];
                              return ListTile(
                                title: Text(
                                  userData != null
                                      ? '${userData['FullName']}'
                                      : 'Loading...', // Show loading or placeholder text
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  textAlign: TextAlign.center,
                                ),
                                subtitle: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      userData != null
                                          ? '${userData['Email']}'
                                          : 'Loading...', // Show loading or placeholder text
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }
                          })
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),

              // MENU
              ProfileMenuWidget(
                title: 'User Managment',
                icon: LineAwesomeIcons.user_check,
                onPress: () {
                  Get.to(() => UpdateProfileScreen());
                },
              ),
              // ProfileMenuWidget(
              //   title: 'Settings',
              //   icon: LineAwesomeIcons.cog,
              //   onPress: () {},
              // ),
              ProfileMenuWidget(
                title: 'Billing Details',
                icon: LineAwesomeIcons.wallet,
                onPress: () {
                  Get.to(() => PaymentScreen());
                },
              ),

              const Divider(),
              const SizedBox(
                height: 10,
              ),

              ProfileMenuWidget(
                title: 'Logout',
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                onPress: () {
                  logOut();
                },
                endIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
