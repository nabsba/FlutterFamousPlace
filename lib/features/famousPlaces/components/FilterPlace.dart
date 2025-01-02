import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../styles/services/typography.dart';

// Create a StateProvider to track the selected index
final selectedButtonProvider = StateProvider<int>((ref) => 0);

class FilterButtons extends ConsumerWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedButtonProvider);
    final List<String> buttons = [
      AppLocalizations.of(context)!.popularPlaces,
      AppLocalizations.of(context)!.nearby,
      AppLocalizations.of(context)!.latest
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(buttons.length, (index) {
        final bool isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () {
            // Update the Riverpod state
            ref.read(selectedButtonProvider.notifier).state = index;
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );
  }
}
