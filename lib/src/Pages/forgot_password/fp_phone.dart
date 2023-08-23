import 'package:flutter/material.dart';
import 'package:my/src/common_widgets/form/form_header_widget.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/imageStrings.dart';
import 'package:my/src/constants/sizes.dart';

class ForgotPasswordPhoneScreen extends StatelessWidget {
  const ForgotPasswordPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                SizedBox(
                  height: tDefaultSize * 4,
                ),
                FormHeaderWidget(
                  image: tForgotPasswordImage,
                  title: ('Forgot Password'),
                  subtitle:
                      'Select one of the options below to ressst your password',
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: tFormHeight,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Phone number',
                          hintText: 'phone number',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0, color: tSecondaryColor)),
                          prefixIcon: Icon(Icons.mail_outline_rounded,
                              color: tSecondaryColor),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgotPassword/otp');
                        },
                        child: const Text('Next'),
                        style: ElevatedButton.styleFrom(
                          textStyle:
                              TextStyle(fontSize: 18), // Change text size
                          backgroundColor:
                              tSecondaryColor, // Change button color
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12), // Change padding
                          // Other style properties...
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
