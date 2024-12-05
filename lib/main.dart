import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/graphql/client.dart';
import 'package:flutter_famous_places/firebase_options.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'features/navigations/services/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    // print(user);
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is in!');
    }
  });
  final graphQLClientSingleton = GraphQLClientSingleton().getNotifier();
  runApp(GraphQLProvider(
      client: graphQLClientSingleton,
      child: ProviderScope(child: const MainApp())));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Favorite Place',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // locale: Locale('fr'),
      supportedLocales: [
        Locale('en'), // English
        Locale('fr'), // Spanish
      ],
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        splashColor:
            Colors.transparent, // renmove the wave effect on button clicked
        useMaterial3: true,
      ),
    );
  }
}
