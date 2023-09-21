import 'package:flutter/material.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/sizes.dart';
// import 'lib/src/constants/imageStrings.dart';
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
      backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
                image: AssetImage(tWelcomeScreenImage),
                height: height * 0.6,
                fit: BoxFit.contain,
                // color: Colors.white,
                colorBlendMode: BlendMode.colorBurn),
            Column(
              children: [
                Text(
                  'Let us chat!!',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        foregroundColor: tSecondaryColor,
                        side: BorderSide(color: tSecondaryColor),
                        padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                      ),
                      child: Text("Login ".toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold))),
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
                        shape: RoundedRectangleBorder(),
                        padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                      ),
                      child: Text(
                        'SignUp'.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
