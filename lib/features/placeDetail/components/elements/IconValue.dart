import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconValueWidget extends StatelessWidget {
  final String icon;
  final String value;
  final TextStyle textStyle;

  const IconValueWidget({
    Key? key,
    required this.icon,
    required this.value,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Adjust to fit content
      children: [
        Container(
          width: 30, // Square width
          height: 30, // Square height
          decoration: BoxDecoration(
            color:
                Color.fromRGBO(237, 237, 237, 1), // Background color (optional)

            borderRadius:
                BorderRadius.circular(4), // Optional for rounded square
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: 15,
              height: 15,
            ),
          ),
        ),
        SizedBox(width: 8.0), // Add spacing
        Text(value, style: textStyle), // Display the value
      ],
    );
  }
}
