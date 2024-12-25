import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final textPainter = TextPainter(
                  text: TextSpan(
                    text: "$name, $location",
                    style: TypographyStyles.roboto500_16.copyWith(
                      fontSize: TypographyStyles.roboto500_16.fontSize,
                    ),
                  ),
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: availableWidth);

                // Check if text fits in the available width
                final needsColumn = textPainter.didExceedMaxLines;

                return needsColumn
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$name,",
                            style: TypographyStyles.roboto500_16.copyWith(
                              color: Colors.white,
                              fontSize: TypographyStyles.roboto500_16.fontSize,
                            ),
                          ),
                          Text(
                            location,
                            style: TypographyStyles.roboto500_16.copyWith(
                              color: const Color.fromRGBO(202, 200, 200, 1),
                              fontSize: TypographyStyles.roboto500_16.fontSize,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "$name, ",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TypographyStyles.roboto500_16.copyWith(
                              color: Colors.white,
                              fontSize: TypographyStyles.roboto500_16.fontSize,
                            ),
                          ),
                          Text(
                            location,
                            style: TypographyStyles.roboto500_16.copyWith(
                              color: const Color.fromRGBO(202, 200, 200, 1),
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
                      // border: Border.all(
                      //   color: Colors.grey, // Border color
                      //   width: 1.0, // Border width
                      // ),
                      borderRadius:
                          BorderRadius.circular(8), // Optional: Rounded corners
                    ),
                    child: Wrap(
                      // Space between rows when wrapped
                      alignment: WrapAlignment
                          .spaceBetween, // Align items to the start
                      children: [
                        // Location Row
                        Row(
                          mainAxisSize:
                              MainAxisSize.min, // Ensures Row wraps its content
                          children: [
                            Transform.translate(
                              offset: Offset(
                                  -5, 0), // Move the icon 1 pixel to the left
                              child: Icon(
                                Icons.location_on,
                                color: const Color.fromRGBO(202, 200, 200, 1),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '$location, $country',
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
                        // Rating Row
                        Row(
                          mainAxisSize:
                              MainAxisSize.min, // Ensures Row wraps its content
                          children: [
                            Icon(Icons.star,
                                color: const Color.fromRGBO(202, 200, 200, 1)),
                            SizedBox(width: AppStylesSpace.extraSmall),
                            Text(
                              rating.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromRGBO(202, 200, 200, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )))
          ],
        ));
  }
}
