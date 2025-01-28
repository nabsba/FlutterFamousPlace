import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/errors_localizations.dart';

class NotConnectedWidget extends StatelessWidget {
  const NotConnectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ErrorsLocalizations.of(context)!
            .connectionError), // App bar with title
        backgroundColor: Colors.red, // Red background for the app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off, // Wi-Fi off icon
              size: 50.0,
              color: Colors.red, // Red color for the icon
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.notConnected,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Red color for the text
              ),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.notConnectedNotSign,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey, // Grey color for additional text
              ),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Action to retry or navigate, e.g., recheck connection
            //     context.go(
            //       '/home', // Pass the place object as an argument
            //     );
            //   },
            //   child: Text('Retry'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue, // Blue color for the button
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
