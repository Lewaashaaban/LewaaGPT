import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {super.key,
      this.ImageColor,
      this.heightBetween,
      required this.image,
      required this.title,
      required this.subtitle,
      this.imageHeight = 0.2,
      this.textAlign,
      this.crossAxisAlignment = CrossAxisAlignment.start});

  final String image, title, subtitle;
  final Color? ImageColor;
  final double? imageHeight;
  final double? heightBetween;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(image),
          height: size.height * 0.2,
        ),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              color: Colors.black54),
        ),
      ],
    );
  }
}
