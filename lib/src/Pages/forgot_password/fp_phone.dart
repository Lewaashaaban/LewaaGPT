// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sort_child_properties_last, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:my/src/common_widgets/form/form_header_widget.dart';
import 'package:my/src/constants/imageStrings.dart';
import 'package:my/src/constants/sizes.dart';

class ForgotPasswordPhoneScreen extends StatefulWidget {
  const ForgotPasswordPhoneScreen({super.key});

  @override
  State<ForgotPasswordPhoneScreen> createState() =>
      _ForgotPasswordPhoneScreenState();
}

class _ForgotPasswordPhoneScreenState extends State<ForgotPasswordPhoneScreen> {
  final _phoneController = TextEditingController();

  Future passwordReset() async {
    try {
      // Send a verification code to the phone number
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Failed to send verification code: ${e.message}'),
              );
            },
          );
        },
        codeSent: (String verificationId, int? resendToken) {
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // The verification code retrieval timed out.
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Verification code retrieval timed out.'),
              );
            },
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(LineAwesomeIcons.angle_left)),
        // title: Text('Reset passsword'),
        centerTitle: true,
      ),
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
                  subtitle: 'Enter your number to send\n a password reset link',
                  // crossAxisAlignment: CrossAxisAlignment.center,
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
                      controller: _phoneController,
                      decoration: InputDecoration(
                          labelText: 'Phone number',
                          hintText: 'phone number',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2.0,
                          )),
                          prefixIcon: Icon(
                            Icons.mail_outline_rounded,
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          passwordReset();
                        },
                        child: const Text('Next'),
                        style: ElevatedButton.styleFrom(
                          textStyle:
                              TextStyle(fontSize: 18), // Change text size
                          // Change button color
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
