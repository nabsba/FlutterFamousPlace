import 'package:flutter/material.dart';

import '../../error/components/error.dart';
import '../services/constant.dart';
import 'CardPlaceSkelaton.dart';

enum LoadingType { skeleton, circular }

class LoadingWidget extends StatefulWidget {
  final Duration timeoutDuration;
  final String errorKey;
  final String loadingType; // Add this property

  const LoadingWidget({
    super.key,
    this.timeoutDuration = const Duration(seconds: 10),
    this.errorKey = 'defaultError',
    this.loadingType = LoaderMessagesKeys.defaultType, // Default to skeleton
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  bool _isTimeout = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(widget.timeoutDuration, () {
      if (mounted) {
        setState(() {
          _isTimeout = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isTimeout) {
      return Center(
        child: ErrorComponent(
          errorKey: widget.errorKey,
        ),
      );
    }

    // Render the loading type based on the passed loadingType
    switch (widget.loadingType) {
      case LoaderMessagesKeys.defaultType:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircularProgressIndicator(),
          ),
        );
      case LoaderMessagesKeys.skelaton:
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [CardPlaceSkeleton(), CardPlaceSkeleton()],
          ),
        );

      default:
        return SizedBox.shrink(); // Fallback for unknown types
    }
  }
}
