import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/client/components/titleNameAvatarRow.dart';
import '../../features/famousPlaces/components/FilterPlace.dart';
import '../../features/famousPlaces/components/places.dart';
import '../../features/inputs/components/inputSearch.dart';
import '../../features/styles/services/typography.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static const routeName = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Aligns title and subtitle to the start
            children: [
              TitleNameAvatarRow(), // Main title
              Text(
                AppLocalizations.of(context)!.exploreTheWorld,
                style: TypographyStyles.inter20.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.color, // Merges the color from bodyText1
                  fontSize: TypographyStyles.inter20
                      .fontSize, // Ensures font size remains the same as TypographyStyles.inter20
                ),
              ),
            ],
          ),
        ), // Optional AppBar for a header
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around contents
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Add space between widgets
              InputSearch(),
              const SizedBox(height: 20),
              FilterButtons(),
              Places()
            ],
          ),
        ),
      ),
    );
  }
}
