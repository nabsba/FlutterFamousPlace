import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/styles/services/size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../styles/services/typography.dart';
import '../services/clientProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleNameAvatarRow extends ConsumerWidget {
  const TitleNameAvatarRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placeProvider);
    return Row(
      children: [
        // Add space between the avatar and text

        Text(
          AppLocalizations.of(context)!.greetingMessage(place!.name),
          style: TypographyStyles.montserrat,
        ),
        const SizedBox(width: AppStylesSpace.smallSpacing),
        SvgPicture.asset(
          'assets/icons/divers/clap.svg',
          width: 25,
          height: 25,
        ),
        const Spacer(),
        CircleAvatar(
          radius: 20, // Adjust the size of the avatar
          backgroundImage: NetworkImage(
            place.photoURL,
          ),
          backgroundColor: Colors.grey[200], // Fallback background
        ),
      ],
    );
  }
}
