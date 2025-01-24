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
