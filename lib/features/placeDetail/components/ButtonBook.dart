import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles/services/typography.dart';

class IconTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color buttonColor;
  final Color textColor;

  const IconTextButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.home,
    this.label = 'Book Now',
    this.buttonColor = const Color.fromARGB(255, 47, 105, 148),
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
                color: textColor,
                fontFamily: TypographyStyles.roboto500_20.fontFamily),
          ),
          SizedBox(width: 8),
          SvgPicture.asset(
            'assets/icons/divers/booking.svg',
            width: 23,
            height: 23,
          )
        ],
      ),
    );
  }
}
