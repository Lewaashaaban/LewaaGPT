// ignore_for_file: prefer_const_constructors, sort_child_properties_last, no_leading_underscores_for_local_identifiers, file_names, sized_box_for_whitespace

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my/src/Backend/contollers/signup_controller.dart';
import 'package:my/src/constants/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Signup"),
          centerTitle: true,
          backgroundColor: tSecondaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.android,
                      size: 100,
                    ),

                    SizedBox(
                      height: 35,
                    ),

                    // hello again
                    Text(
                      'Hello There',
                      style: GoogleFonts.bebasNeue(fontSize: 52),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Register below with your details!',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: controller.fullName,
                      decoration: InputDecoration(
                          labelText: 'Full Name',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2.0,
                          )),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: controller.email,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0)),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: controller.phoneNo,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: '+961********',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0)),
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: controller.password,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          // labelStyle: TextStyle(color: tSecondaryColor),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0)),
                          prefixIcon: Icon(Icons.fingerprint),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // SignupController.instance.phoneAuthentication(
                            //     controller.phoneNo.text.trim());
                            // Get.to(() => const OTPscreen());

                            // 3- GET USER AND PASSSWORD TO CONTROLLER
                            // final user = UserModel(
                            //   email: controller.email.text.trim(),
                            //   passsword: controller.password.text.trim(),
                            //   fullName: controller.fullName.text.trim(),
                            //   phoneNo: controller.phoneNo.text.trim(),
                            // );
                            SignupController.instance.signup(context);

                            // Get.to(() => const OTPscreen());
                            // Navigator.pushNamed(context, '/chat');
                          }
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 5,
                          // backgroundColor: tSecondaryColor, // Button color
                          textStyle: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    TextButton(
                        onPressed: () {},
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Already Have an Account ? ',
                                style: Theme.of(context).textTheme.bodyLarge),
                            TextSpan(text: 'Login')
                          ])),
                        ))
                  ]),
            ),
          ),
        ));
  }
}
