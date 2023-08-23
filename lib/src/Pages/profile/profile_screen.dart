import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:my/src/Pages/chat/chatScreen.dart';
// import 'package:my/src/Pages/chat/chatScreen.dart';
// import 'package:my/src/Pages/homepage.dart';
import 'package:my/src/Pages/profile/update_profile_screen.dart';
import 'package:my/src/Pages/profile/widgets/profile_menu.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/imageStrings.dart';
import 'package:my/src/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> userData = {};

// Check if the 'fullName' field is written
    bool isFullNameWritten = userData.containsKey('fullName') &&
        userData['fullName'] != null &&
        userData['fullName'] != '';

// ... Inside your widget tree ...
    if (isFullNameWritten) {
      Text(
        userData['fullName'],
        style: Theme.of(context).textTheme.headlineMedium,
      );
    } else {
      Text(
        'Full Name Not Provided',
        style: Theme.of(context).textTheme.headlineMedium,
      );
    }

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: tWhiteColor,
        leading: IconButton(
          onPressed: () {
            Get.to(() => ChatScreen());
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
              onPressed: () {
                Get.back();
              },
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
                          image: AssetImage(tLewaaImage),
                        )),
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
              const SizedBox(
                height: 10,
              ),
              Text(
                user?.uid ?? '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                user?.email ?? '',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 22.0),
              ),
              const SizedBox(height: 20),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => {
                      Get.to(() => const UpdateProfileScreen()),
                    },
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(color: tDarkColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColor,
                      side: BorderSide.none,
                      shape: StadiumBorder(),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),

              // MENU
              ProfileMenuWidget(
                title: 'Settings',
                icon: LineAwesomeIcons.cog,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: 'Billing Details',
                icon: LineAwesomeIcons.wallet,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: 'User Managment',
                icon: LineAwesomeIcons.user_check,
                onPress: () {},
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                title: 'Information',
                icon: LineAwesomeIcons.info,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: 'Logout',
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                onPress: () {
                  Get.offAllNamed('/');
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
