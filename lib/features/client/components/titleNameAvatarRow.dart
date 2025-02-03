import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/styles/services/size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../connectivityState/providers/connectivityHelper.dart';
import '../../styles/services/typography.dart';
import '../providers/clientProvider.dart';

class TitleNameAvatarRow extends ConsumerWidget {
  const TitleNameAvatarRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfos = ref.watch(userInfosProvider);
    final connectivityState = ref.watch(connectivityProvider);
    final isConnected =
        connectivityState.value != null && connectivityState.value == true;
    return Row(
      children: [
        // Add space between the avatar and text

        Text(
          AppLocalizations.of(context)!.greetingMessage(userInfos?.name ?? ""),
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
          backgroundImage: userInfos?.photoURL.isNotEmpty == true
              ? isConnected
                  ? NetworkImage(userInfos!.photoURL)
                  : AssetImage("assets/images/userDefault.jpg") as ImageProvider
              : AssetImage("assets/images/userDefault.jpg") as ImageProvider,
          backgroundColor: Colors.grey[200], // Fallback background
        ),
      ],
    );
  }
}
