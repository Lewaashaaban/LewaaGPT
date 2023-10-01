// ignore_for_file: prefer_const_constructors, file_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/sizes.dart';
import 'package:my/src/constants/imageStrings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: tPrimaryColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: height,
          padding: EdgeInsets.symmetric(horizontal: tDefaultSize, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // SizedBox(
              //   height: 20,
              // ),
              Center(
                child: Container(
                  height: height / 2,
                  width: 600,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        tmylogo4,
                      ),
                    ),
                  ),
                ),
              ),

              // Column(
              //   children: [
              //     Text(
              //       "Welcome!",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: tDefaultSize,
              //           color: tSecondaryColor),
              //     ),
              //     // Text(
              //     //   'Let us chat!!',
              //     //   style: Theme.of(context)
              //     //       .textTheme
              //     //       .displaySmall
              //     //       ?.copyWith(fontWeight: FontWeight.bold),
              //     // ),
              //   ],
              // ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        backgroundColor: tWhiteColor,
                        side: BorderSide(color: tSecondaryColor),
                        padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                      ),
                      child: Text("Login ".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tSecondaryColor)),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          padding:
                              EdgeInsets.symmetric(vertical: tButtonHeight),
                          backgroundColor: tSecondaryColor,
                        ),
                        child: Text(
                          'SignUp'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: tWhiteColor),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
