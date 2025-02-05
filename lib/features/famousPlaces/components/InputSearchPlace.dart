import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../client/providers/clientProvider.dart';
import '../../common/services/functions.dart';
import '../../styles/services/typography.dart';
import '../services/PreselectonName.dart';
import '../services/data/constant.dart';
import '../services/graphql/graphQlQuery.dart';
import '../services/providers/fetchPlaces.dart';
import '../services/providers/menuSelected.dart';
import '../services/providers/places.dart';
import '../../graphql/client.dart';

class InputSearch extends ConsumerStatefulWidget {
  const InputSearch({super.key});

  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends ConsumerState<InputSearch> {
  final TextEditingController _controller = TextEditingController();
  final List<Selection> _suggestions = [];
  Timer? _debounce;
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final query = _controller.text.trim();
      if (query.isNotEmpty) {
        final placeRepository = PlaceRepository(GraphQLClientManager().client);
        final userInfos = ref.watch(userInfosProvider);
        final locale = Localizations.localeOf(context);
        final languageIndex = getIndexOfLanguage(locale.toString());
        final menuSelectedd = ref.read(menuSelected).menuOnSelection;
        final results = await placeRepository.preselectionNames(
          query,
          languageIndex.toString(),
          menuSelectedd,
          userInfos!.userId,
        );
        final nanb = PreselectionNameData.fromMap(results.data!);

        setState(() {
          _suggestions
            ..clear()
            ..addAll(nanb.selections);
        });
      } else {
        setState(() {
          _suggestions.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(255, 218, 218, 218),
              width: 2,
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  cursorColor: const Color.fromARGB(255, 223, 21, 21),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchPlaces,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 2,
                color: const Color.fromARGB(255, 211, 211, 211),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: GestureDetector(
                  onTap: () {
                    if (_selectedId != null && _selectedId!.isNotEmpty) {
                      ref
                          .read(menuSelected.notifier)
                          .updateMenuOnSelection(menus[3]);
                      final place = ref.watch(placesProvider)[menus[3]];
                      if (place!.isNotEmpty &&
                          _selectedId == place[0]['placeDetail']['id']) {
                        return;
                      }
                      ref
                          .read(placesNotifierProvider.notifier)
                          .fetchPlace(ref, context, _selectedId!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.noPLaceSelected,
                          style: TypographyStyles.roboto500_16.copyWith(
                            color: Colors.white, // White for name
                            fontWeight: FontWeight.bold, // Bold for name
                            fontSize: TypographyStyles.roboto500_16.fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ));
                    }
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
        // Use a StatefulBuilder to force a rebuild of the Visibility widget
        StatefulBuilder(
          builder: (context, setState) {
            return Visibility(
              visible: _suggestions.isNotEmpty,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 200),
                margin:
                    const EdgeInsets.only(top: 8), // Spacing below the input
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _suggestions[index];
                    return ListTile(
                      title: Text(suggestion.name),
                      onTap: () {
                        // Temporarily remove the listener to prevent reopening
                        _controller.removeListener(_onSearchChanged);

                        // Update the text and selected ID
                        _controller.text = suggestion.name;
                        _selectedId = suggestion.id;

                        // Clear suggestions and force a rebuild
                        setState(() {
                          _suggestions.clear();
                        });

                        // Re-add the listener after a short delay
                        Future.delayed(const Duration(milliseconds: 100), () {
                          _controller.addListener(_onSearchChanged);
                        });
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
