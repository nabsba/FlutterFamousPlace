import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../features/client/components/titleNameAvatarRow.dart';
import '../../features/typohraphies/typography.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
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
              const Center(
                child: Text(
                  'Hello Home',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
