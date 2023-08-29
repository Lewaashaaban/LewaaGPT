// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:my/src/Backend/contollers/getUserData.dart';
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
  @override
  void initState() {
    super.initState();
    fetchUserData();
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
                        child: Image(
                          image: AssetImage(tUSerIamge),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: tPrimaryColor,
                      ),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
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
                onPress: () {},
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
