import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../styles/services/typography.dart';

class MenusPlaceDetail extends ConsumerWidget {
  const MenusPlaceDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> buttons = [
      AppLocalizations.of(context)!.overview,
      AppLocalizations.of(context)!.details,
    ];
    return Align(
      alignment: Alignment.centerLeft, // Align the Row to the left
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align items to the left
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(buttons.length, (index) {
          return GestureDetector(
              onTap: () {
                print('ok');
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: index > 0 ? 15.0 : 0.0), // Add spacing between items
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  buttons[index],
                  style: index == 0
                      ? TypographyStyles.inter22.copyWith(
                          color: Color.fromRGBO(27, 27, 27, 1),
                          fontWeight: FontWeight.normal,
                        )
                      : TypographyStyles.inter16.copyWith(
                          color: Colors.grey,
                        ),
                ),
              ));
        }),
      ),
    );
  }
}
