// import 'dart:ui';
// import 'package:flutter/material.dart';
// import '../../../styles/services/typography.dart';

// class BlurredTextWidget extends StatelessWidget {
//   final String text;

//   const BlurredTextWidget({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     List<String> lines = text.split('.');
//     lines = lines
//         .map((line) => line.trim())
//         .where((line) => line.isNotEmpty)
//         .toList();
//     String partOne = '';
//     String partTwo = '';
//     // String partThree = '';
//     if (lines.length > 2) {
//       // Join the first two sentences into partOne
//       partOne = '${lines.take(1).join('. ')}.';
//       // Join the remaining sentences into partTwo
//       partTwo = '${lines.skip(1).join('. ')}.';
//       // partThree = '${lines.skip(1).join('. ')}.';
//     } else {
//       // If there are fewer than 3 sentences, put all of them in partOne
//       partOne = '${lines.join('. ')}.';
//     }

//     return Text(text);
//     return RichText(
//       text: TextSpan(
//         children: [
//           TextSpan(
//             text: partOne,
//             style: TypographyStyles.roboto500_16.copyWith(
//               color: Color.fromRGBO(165, 165, 165, 1),
//               fontSize: TypographyStyles.roboto500_18.fontSize,
//             ),
//           ),
//           WidgetSpan(
//             child: ImageFiltered(
//               imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
//               child: Text(
//                 partTwo,
//                 maxLines: 3,
//                 style: TypographyStyles.roboto500_16.copyWith(
//                   color: Color.fromRGBO(165, 165, 165, 1),
//                   fontSize: TypographyStyles.roboto500_18.fontSize,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:ui';

class BlurredTextWidget extends StatelessWidget {
  final String text;

  const BlurredTextWidget({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // Full text displayed normally
        Text(
          text,
          style: TextStyle(fontSize: 16),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        // Blurred effect over part of the second line
        Positioned(
          top: 42, // Adjust to align with the second line
          left: 0, // Adjust to cover the middle of the second line
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7),
              child: Container(
                width: 400, // Width of the blur area
                height: 50, // Height of the blur area
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
