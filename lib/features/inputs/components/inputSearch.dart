import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputSearch extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(255, 218, 218, 218), // Border color
              width: 2, // Border width
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  cursorColor: const Color.fromARGB(255, 146, 146, 146),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchPlaces,
                    border: InputBorder.none, // Removes default border
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10), // Padding for content
                  ),
                ),
              ),
              Container(
                height: 30, // Height of the separator
                width: 2, // Width of the separator
                color: const Color.fromARGB(
                    255, 211, 211, 211), // Color of the separator
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: GestureDetector(
                  onTap: () {
                    print('User input: ${_controller.text}');
                  },
                  child: SvgPicture.asset(
                    'assets/icons/divers/search.svg',
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
