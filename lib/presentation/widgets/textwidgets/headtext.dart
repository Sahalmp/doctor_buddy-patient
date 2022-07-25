import 'package:flutter/material.dart';

import '../../../domain/colors.dart';

class HeadingText extends StatelessWidget {
  final String text;
  const HeadingText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 32,
          color: primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 2),
    );
  }
}
