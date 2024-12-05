import 'package:flutter/material.dart';

class ConditionalAnimatedSwitcher extends StatelessWidget {
  final Widget firstWidget;
  final Widget secondWidget;
  final Duration duration;
  final bool condition;

  const ConditionalAnimatedSwitcher({
    super.key,
    required this.firstWidget,
    required this.secondWidget,
    required this.duration,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      child: condition ? firstWidget : secondWidget,
    );
  }
}
