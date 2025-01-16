import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/providers/fetchPlaces.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../styles/services/typography.dart';
import '../services/providers/indexMenu.dart';

class SelectMenuType extends ConsumerWidget {
  const SelectMenuType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(menuSelected).newIndex;
    final List<String> buttons = [
      AppLocalizations.of(context)!.mostViewed,
      AppLocalizations.of(context)!.nearby,
      AppLocalizations.of(context)!.latest,
      'onSelection'
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: Row(
        children: List.generate(buttons.length, (index) {
          final bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              if (ref.watch(menuSelected).newIndex != index) {
                ref.read(menuSelected.notifier).updateIndex(index);
                ref
                    .read(placesNotifierProvider.notifier)
                    .fetchMoreData(ref, context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: index > 0 ? 15.0 : 0.0), // Add spacing between items
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF2F2F2F)
                    : const Color.fromARGB(255, 245, 244, 244),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                buttons[index],
                style: TypographyStyles.roboto500_16.copyWith(
                  color: isSelected
                      ? Colors.white
                      : const Color.fromARGB(197, 197, 197, 197),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
