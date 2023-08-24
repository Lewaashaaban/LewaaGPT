// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:my/src/Pages/chat/chatScreen.dart';
// import 'package:my/src/Pages/homepage.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/sizes.dart';
import 'package:my/src/Backend/authentication/contollers/otp_controller.dart';

class OTPscreen extends StatelessWidget {
  const OTPscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var otp;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CO\nDE',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
              ),
            ),
            Text(
              ' Verification '.toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Enter the verification code sent at  shaabanlewaa@gmail.com',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) {
                otp = code;
                OTPController.instance.verifyOTP(otp);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    OTPController.instance.verifyOTP(otp).then((isCorrect) {
                      if (isCorrect) {
                        Navigator.pushNamed(context, '/login');
                      } else {
                        // Show a snackbar or alert dialog to indicate incorrect verification code
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Incorrect verification code. Please try again.'),
                          ),
                        );
                      }
                    });
                  },
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 5,
                    backgroundColor: tSecondaryColor,
                    foregroundColor: Colors.white, // Button color
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
