import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/services/functions.dart';
import '../../../styles/services/size.dart';
import '../../../styles/services/typography.dart';

class DescriptionCard extends StatelessWidget {
  final String name;
  final String location;
  final String country;
  final int rating;

  const DescriptionCard({
    super.key,
    required this.name,
    required this.location,
    required this.country,
    required this.rating,
  });

  // Function to simplify text styling and truncation

  @override
  Widget build(BuildContext context) {
    int maxLength = 17;
    Map<String, String> resultCityCountry = calculateAuthorizedLength(
        valueToTruncat: location,
        valueToNotTouch: country,
        authorizedLength: maxLength);
    // Access the name and location from the map
    String displayedCity = resultCityCountry['valueToTruncat'] ?? '';
    String displayedCountry = resultCityCountry['valueToNotTouch'] ?? '';

    Map<String, String> resultNameLocation = calculateAuthorizedLength(
        valueToTruncat: name,
        valueToNotTouch: location,
        authorizedLength: maxLength);
    // Access the name and location from the map
    String displayedName = resultNameLocation['valueToTruncat'] ?? '';
    String displayedLocation = resultNameLocation['valueToNotTouch'] ?? '';

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and Location with dynamic truncation
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  // Name with white and bold
                  Text(
                    displayedName,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TypographyStyles.roboto500_16.copyWith(
                      color: Colors.white, // White for name
                      fontWeight: FontWeight.bold, // Bold for name
                      fontSize: TypographyStyles.roboto500_16.fontSize,
                    ),
                  ),
                  // Location with default style
                  Text(
                    ', $displayedLocation',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TypographyStyles.roboto500_16.copyWith(
                      color: const Color.fromRGBO(
                          202, 200, 200, 1), // Grey for location
                      fontSize: TypographyStyles.roboto500_16.fontSize,
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 5),
          // Location and Country
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  // Location and Country Row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: Offset(-5, 0),
                        child: SvgPicture.asset(
                          'assets/icons/divers/location.svg',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '$displayedCity ',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TypographyStyles.roboto500_14.copyWith(
                            color: const Color.fromRGBO(202, 200, 200, 1),
                            fontSize: TypographyStyles.roboto500_14.fontSize,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          displayedCountry,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TypographyStyles.roboto500_14.copyWith(
                            color: const Color.fromRGBO(202, 200, 200, 1),
                            fontSize: TypographyStyles.roboto500_14.fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Rating Row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/divers/stars.svg',
                        width: 10,
                        height: 10,
                      ),
                      SizedBox(width: AppStylesSpace.extraSmall),
                      Text(
                        rating.toString(),
                        style: TypographyStyles.roboto500_16.copyWith(
                          fontSize: TypographyStyles.roboto500_16.fontSize,
                          color: const Color.fromRGBO(202, 200, 200, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
