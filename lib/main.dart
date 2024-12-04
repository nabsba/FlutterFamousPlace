import 'package:flutter/material.dart';
import 'features/navigations/services/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Favorite Place',
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
