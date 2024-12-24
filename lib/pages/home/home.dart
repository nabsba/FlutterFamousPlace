import 'package:flutter/material.dart';

import '../../features/client/components/titleNameAvatarRow.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TitleNameAvatarRow(),
        ), // Optional AppBar for a header
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around contents
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Add space between widgets
              const Center(
                child: Text(
                  'Hello Home',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
