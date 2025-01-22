import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../styles/services/typography.dart';

class BlurredTextWidget extends StatelessWidget {
  final String text;

  const BlurredTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<String> lines = text.split('.');
    lines = lines
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    String partOne = '';
    String partTwo = '';
    String partThree = '';
    if (lines.length > 2) {
      // Join the first two sentences into partOne
      partOne = '${lines.take(1).join('. ')}.';
      // Join the remaining sentences into partTwo
      partTwo = '${lines.skip(1).join('. ')}.';
      partThree = '${lines.skip(1).join('. ')}.';
    } else {
      // If there are fewer than 3 sentences, put all of them in partOne
      partOne = '${lines.join('. ')}.';
    }

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: partOne,
            style: TypographyStyles.roboto500_16.copyWith(
              color: Color.fromRGBO(165, 165, 165, 1),
              fontSize: TypographyStyles.roboto500_18.fontSize,
            ),
          ),
          WidgetSpan(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
              child: Text(
                partTwo,
                maxLines: 2,
                style: TypographyStyles.roboto500_16.copyWith(
                  color: Color.fromRGBO(165, 165, 165, 1),
                  fontSize: TypographyStyles.roboto500_18.fontSize,
                ),
              ),
            ),
          ),
          WidgetSpan(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2.3, sigmaY: 2.3),
              child: Text(
                partThree,
                maxLines: 2,
                style: TypographyStyles.roboto500_16.copyWith(
                  color: Color.fromRGBO(165, 165, 165, 1),
                  fontSize: TypographyStyles.roboto500_18.fontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
