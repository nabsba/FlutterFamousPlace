import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainCover extends StatelessWidget {
  const MainCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0172B2), // #0172B2
            Color(0xFF001645), // #001645
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Aligns content vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Aligns content horizontally
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centers the row
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Centers the text and icon vertically
              children: [
                Text(
                  AppLocalizations.of(context)!.travel,
                  style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  textAlign: TextAlign.center, // Ensures the text is centered
                ),
                SizedBox(width: 8), // Adds space between the text and the icon
                SvgPicture.asset(
                  'assets/icons/divers/travel.svg',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0436,
            ), // Adds space between the two texts
            Text(AppLocalizations.of(context)!.travelMessage,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
