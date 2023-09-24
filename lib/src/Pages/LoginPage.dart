// ignore_for_file: prefer_const_constructors, prefer_final_fields, library_private_types_in_public_api, unused_field, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, sort_child_properties_last, file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my/src/Backend/contollers/login_controller.dart';
import 'package:my/src/Pages/forgot_password/fp_mail.dart';
import 'package:my/src/Pages/forgot_password/fp_phone.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/sizes.dart';
import './SignupPage.dart';
// import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
        backgroundColor: tSecondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the form key to the Form widget
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // logo
                Icon(
                  Icons.android,
                  size: 100,
                ),

                SizedBox(
                  height: 35,
                ),

                // hello again
                Text(
                  'Hello Again',
                  style: GoogleFonts.bebasNeue(fontSize: 52),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome back, you\'ve been miseed',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 50,
                ),

                // Email TextField
                TextFormField(
                  controller: controller.email,
                  decoration: InputDecoration(
                    labelText: 'Enter email adress ',
                    hintText: 'test@example.com',
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),

                // password TextField
                TextFormField(
                  controller: controller.password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',
                    // filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: tSecondaryColor)),
                    prefixIcon: Icon(
                      Icons.password,
                    ),
                    suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.remove_red_eye_sharp),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.0),

                // FORGOT PASSSWORD BTN
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          builder: (context) => Container(
                                padding: EdgeInsets.all(tDefaultSize),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Make Selection!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                        'Select one of the options given below to reset your password',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    ForgetPasswordBtnWidget(
                                      btnIcon: Icons.mail_outline_rounded,
                                      title: 'E-mail',
                                      subtitle: 'Reset via E-mail address',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPasswordMailScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    ForgetPasswordBtnWidget(
                                      btnIcon: Icons.mobile_friendly_rounded,
                                      title: 'Phone No',
                                      subtitle: 'Reset via Phone Number',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordPhoneScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ));
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),

                // LOGIN BTN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, perform the login logic here
                          LoginController.instance.login(context);
                          // Navigator.pushNamed(context, '/chat');
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        // Button color
                        textStyle: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                // DON'T HAVE AN ACCOUNT? SIGNUP
                RichText(
                  text: TextSpan(
                    text: "Don't have an account?   ",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "SignUp",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            );
                          },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordBtnWidget extends StatelessWidget {
  const ForgetPasswordBtnWidget({
    required this.btnIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData btnIcon;
  final String title, subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200,
          ),
          child: Row(
            children: [
              Icon(
                btnIcon,
                size: 60.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontSize: 16, color: Colors.black),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
