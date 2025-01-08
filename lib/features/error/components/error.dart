import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/styles/services/size.dart';
import 'package:flutter_gen/gen_l10n/errors_localizations.dart';

import '../../styles/services/typography.dart';

extension LocalizedString on ErrorsLocalizations {
  String getMessage(String key) {
    final map = {
      'login': login,
      'registerUser': registerUser,
      'registerUserWithCookie': registerUserWithCookie,
      'refreshToken': refreshToken,
      'token': token,
      'defaultError': defaultError,
      'cannotLoadMoreData': cannotLoadMoreData,
      'getPlaces': getPlaces,
      'getPlace': getPlace,
      'notAllowed': notAllowed
    };

    return map[key] ?? map['defaultError']!; // Default message if key not found
  }
}

class ErrorComponent extends StatelessWidget {
  final String errorKey;

  const ErrorComponent({super.key, required this.errorKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppStylesSpace.largeSpacing),
        Text(ErrorsLocalizations.of(context)!.getMessage(errorKey),
            style: TypographyStyles.roboto500_16.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontSize: TypographyStyles.roboto500_16.fontSize,
            )),
        //       Text(AppLocalizations.of(context)!.errors[errorKey]) => notWorking
      ],
    );
  }
}
