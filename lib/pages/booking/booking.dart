import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});
  static const routeName = "/booking";
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Hello Booking page',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ));
  }
}
