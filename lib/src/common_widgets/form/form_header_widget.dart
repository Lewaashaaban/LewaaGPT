// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {super.key,
      this.ImageColor,
      this.heightBetween,
      required this.image,
      required this.subtitle,
      this.imageHeight = 0.2,
      this.textAlign,
      this.crossAxisAlignment = CrossAxisAlignment.start});

  final String image, subtitle;
  final Color? ImageColor;
  final double? imageHeight;
  final double? heightBetween;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(image),
          height: size.height * 0.2,
        ),
        SizedBox(
          height: 20,
        ),
        // Text(
        //   title.toUpperCase(),
        //   style: Theme.of(context).textTheme.displaySmall?.copyWith(
        //         fontSize: 24,
        //         fontWeight: FontWeight.bold,
        //       ),
        // ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subtitle,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
