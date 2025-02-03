// ignore: file_names
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../connectivityState/providers/connectivityHelper.dart';

// Replace this with your actual connectivity provider

class ConnectivityStatusBanner extends ConsumerStatefulWidget {
  const ConnectivityStatusBanner({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConnectivityStatusBannerState createState() =>
      _ConnectivityStatusBannerState();
}

class _ConnectivityStatusBannerState
    extends ConsumerState<ConnectivityStatusBanner> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkAndShowBanner();
  }

  @override
  void didUpdateWidget(covariant ConnectivityStatusBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkAndShowBanner();
  }

  void _checkAndShowBanner() {
    _timer?.cancel();
    setState(() => _visible = true);
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _visible = false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectivityState = ref.watch(connectivityProvider);

    // Listen to changes in the connectivity status
    ref.listen<AsyncValue<bool>>(connectivityProvider, (previous, next) {
      if (previous?.value != next.value) {
        _checkAndShowBanner();
      }
    });

    final isOnline = connectivityState.when(
      data: (value) => value,
      loading: () => false, // Assume offline while loading
      error: (_, __) => false, // Assume offline on error
    );

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: _visible ? 0 : -60, // Change from 'top' to 'bottom'
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(12),
          color: isOnline ? Colors.green : Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isOnline ? Icons.wifi : Icons.wifi_off,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                isOnline
                    ? AppLocalizations.of(context)!.backOnline
                    : AppLocalizations.of(context)!.offlineMode,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
