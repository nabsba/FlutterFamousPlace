import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/styles/services/size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/client/components/titleNameAvatarRow.dart';
import '../../features/famousPlaces/components/SelectMenu.dart';
import '../../features/famousPlaces/components/places.dart';
import '../../features/famousPlaces/components/InputSearchPlace.dart';
import '../../features/styles/services/typography.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static const routeName = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, // Aligns title and subtitle to the start
          children: [
            TitleNameAvatarRow(), // Main title
            Text(
              AppLocalizations.of(context)!.exploreTheWorld,
              style: TypographyStyles.inter20.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color, // Merges the color from bodyText1
                fontSize: TypographyStyles.inter20
                    .fontSize, // Ensures font size remains the same as TypographyStyles.inter20
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around contents
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height: AppStylesSpace
                      .mediumSpacing), // Add space between widgets
              InputSearch(),
              const SizedBox(height: AppStylesSpace.largeSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.popularPlaces,
                    style: TypographyStyles.poppins.copyWith(
                      color: Color.fromARGB(
                          255, 47, 47, 47), // Merges the color from bodyText1
                      fontSize: TypographyStyles.roboto500_16
                          .fontSize, // Ensures font size remains the same as TypographyStyles.inter20
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.viewAll,
                    style: TypographyStyles.inter20.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color, // Merges the color from bodyText1
                      fontSize: TypographyStyles.inter20
                          .fontSize, // Ensures font size remains the same as TypographyStyles.inter20
                    ),
                  )
                ],
              ),
              const SizedBox(height: AppStylesSpace.largeSpacing),
              SelectMenuType(),
              const SizedBox(height: AppStylesSpace.largeSpacing),
              Places()
            ],
          ),
        ),
      ),
    );
  }
}
