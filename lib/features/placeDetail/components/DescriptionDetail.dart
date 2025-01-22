import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/common/services/functions.dart';
import 'package:flutter_famous_places/features/styles/services/typography.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../types/DescriptionCardArguments.dart';

class DescriptionDetail extends StatelessWidget {
  final DescriptionDetailArgument descriptionDetailArgument;

  const DescriptionDetail({
    super.key,
    required this.descriptionDetailArgument,
  });

  // Function to simplify text styling and truncation
  @override
  Widget build(BuildContext context) {
    int maxLength = 17;
    Map<String, String> resultNamePrice = calculateAuthorizedLength(
        valueToTruncat: descriptionDetailArgument.name,
        valueToNotTouch: descriptionDetailArgument.priceLabel.toString(),
        authorizedLength: maxLength);
    // Access the name and price from the map
    String displayName = resultNamePrice['valueToTruncat'] ?? '';
    String displayedLabelPrice = resultNamePrice['valueToNotTouch'] ?? '';

    Map<String, String> resultNameLocation = calculateAuthorizedLength(
        valueToTruncat: descriptionDetailArgument.country,
        valueToNotTouch: descriptionDetailArgument.city,
        authorizedLength: maxLength);
    // Access the name and price from the map
    String displayCountry = resultNameLocation['valueToTruncat'] ?? '';
    String displayCity = resultNameLocation['valueToNotTouch'] ?? '';

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Name and Location with dynamic truncation
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Distribute space evenly
                children: [
                  // Name with white and bold
                  Text(
                    displayName,
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
                    displayedLabelPrice,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TypographyStyles.roboto500_16.copyWith(
                      color: const Color.fromRGBO(
                          202, 200, 200, 1), // Grey for price
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Use for space between elements
                  crossAxisAlignment:
                      CrossAxisAlignment.end, // Align children at the bottom
                  children: [
                    // Name & Label
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5.0), // Adjust the padding as needed
                      child: Row(
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
                              '$displayCountry, ',
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                              style: TypographyStyles.roboto500_14.copyWith(
                                color: const Color.fromRGBO(202, 200, 200, 1),
                                fontSize:
                                    TypographyStyles.roboto500_14.fontSize,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              displayCity,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                              style: TypographyStyles.roboto500_14.copyWith(
                                color: const Color.fromRGBO(202, 200, 200, 1),
                                fontSize:
                                    TypographyStyles.roboto500_14.fontSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), // Devise price
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.devise,
                          style: TypographyStyles.roboto500_16.copyWith(
                            fontSize: TypographyStyles.roboto500_20.fontSize,
                            color: const Color.fromRGBO(67, 67, 67, 1),
                          ),
                        ),
                        Text(
                          descriptionDetailArgument.priceValue.toString(),
                          style: TypographyStyles.roboto500_26.copyWith(
                            fontSize: TypographyStyles.roboto500_26.fontSize,
                            color: const Color.fromRGBO(202, 200, 200, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
