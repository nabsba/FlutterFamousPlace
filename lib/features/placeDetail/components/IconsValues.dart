import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/placeDetail/components/elements/IconValue.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../graphql/client.dart';
import '../../styles/services/typography.dart';
import '../services/graphql/graphQlQuery.dart';
import '../types/IconsValuesArguments.dart';

class IconsValuesWidget extends StatelessWidget {
  final IconValueArguments iconsValuesArguments;
  const IconsValuesWidget({super.key, required this.iconsValuesArguments});

  @override
  Widget build(BuildContext context) {
    // Fetch the weather data (or any other relevant data)
    Future value = PlaceDetailService(GraphQLClientManager().client)
        .getWeather(iconsValuesArguments.city);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconValueWidget(
          icon: 'assets/icons/divers/time.svg',
          value:
              '${iconsValuesArguments.hoursTravel} ${AppLocalizations.of(context)!.hours}',
          textStyle: TextStyle(
              fontSize: TypographyStyles.roboto500_18.fontSize,
              color: Color.fromRGBO(126, 126, 126, 1)),
        ),
        IconValueWidget(
          icon: 'assets/icons/divers/star.svg',
          value: '${iconsValuesArguments.popularity}',
          textStyle: TextStyle(
              fontSize: TypographyStyles.roboto500_18.fontSize,
              color: Color.fromRGBO(126, 126, 126, 1)),
        ),
        FutureBuilder(
          future: value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // We do not display anything;
              return Text('');
            } else if (snapshot.hasData) {
              final result = snapshot.data!;
              return IconValueWidget(
                icon: 'assets/icons/divers/cloud.svg',
                value: (result.data['temperature'] as num).round().toString(),
                textStyle: TextStyle(
                    fontSize: TypographyStyles.roboto500_18.fontSize,
                    color: Color.fromRGBO(126, 126, 126, 1)),
              );
            } else {
              return Text('');
            }
          },
        ),
      ],
    );
  }
}
