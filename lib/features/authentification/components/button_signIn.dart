import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../error/services/MyLogger.dart';

class SignInButton extends StatelessWidget {
  final Future<void> Function() onPressed;
  final String iconType;

  const SignInButton({
    super.key,
    required this.onPressed,
    required this.iconType,
  });

  String _getIcon(String iconType) {
    switch (iconType.toLowerCase()) {
      case 'google':
        return 'assets/icons/medias/google.svg';
      case 'git':
        return 'assets/icons/medias/git.svg';
      default:
        return ""; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.7; // 70% of screen width
    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton.icon(
          onPressed: () async {
            try {
              await onPressed();
            } catch (e) {
              MyLogger.logError(e as String);
            }
          },
          icon: SvgPicture.asset(
            _getIcon(iconType), // Assuming _getIcon returns the asset path
            width: 25,
            height: 25,
          ),
          label: Text('Sign in using $iconType'),
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  12), // Optional: to give rounded corners
            ),
          ),
        ),
      ),
    );
  }
}
