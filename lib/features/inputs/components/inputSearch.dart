import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../client/providers/clientProvider.dart';
import '../../common/services/functions.dart';
import '../../famousPlaces/services/PreselectonName.dart';
import '../../famousPlaces/services/graphql/graphQlQuery.dart';
import '../../famousPlaces/services/providers/fetchPlaces.dart';
import '../../famousPlaces/services/providers/menuSelected.dart';
import '../../famousPlaces/services/providers/places.dart';
import '../../graphql/client.dart';

class InputSearch extends ConsumerStatefulWidget {
  const InputSearch({Key? key}) : super(key: key);

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
                  cursorColor: const Color.fromARGB(255, 146, 146, 146),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: GestureDetector(
                  onTap: () {
                    if (_selectedId!.isNotEmpty) {
                      ref
                          .read(menuSelected.notifier)
                          .updateIndex('onSelection');
                      final place = ref.watch(placesProvider)['onSelection'];
                      if (place!.isNotEmpty &&
                          _selectedId == place[0]['placeDetail']['id']) {
                        return;
                      }

                      ref
                          .read(placesNotifierProvider.notifier)
                          .fetchPlace(ref, context, _selectedId!);
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
        Visibility(
          visible: _suggestions.isNotEmpty,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            margin: const EdgeInsets.only(top: 8), // Spacing below the input
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
                    _controller.text = suggestion.name;
                    _selectedId = suggestion.id;
                    setState(() {
                      _suggestions.clear();
                    });
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
