import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/styles/services/size.dart';
import 'package:flutter_gen/gen_l10n/errors_localizations.dart';

extension LocalizedString on ErrorsLocalizations {
  String getMessage(String key) {
    final map = {
      'login': login,
      'registerUser': registerUser,
      'registerUserWithCookie': registerUserWithCookie,
      'refreshToken': refreshToken,
      'token': token,
      'defaultError': defaultError,
    };

    return map[key] ?? map['defaultError']!; // Default message if key not found
  }
}

class ErrorComponent extends StatelessWidget {
  final String errorKey;

  // Constructor to accept the errorKey
  const ErrorComponent({super.key, required this.errorKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Page"),
      ),
      body: Column(
        children: [
          Text(errorKey), // Use the message passed in the constructor
          SizedBox(height: AppStylesSpace.largeSpacing),
          Text(ErrorsLocalizations.of(context)!.getMessage(errorKey)),
          //       Text(AppLocalizations.of(context)!.errors[errorKey]),
        ],
      ),
    );
  }
}
