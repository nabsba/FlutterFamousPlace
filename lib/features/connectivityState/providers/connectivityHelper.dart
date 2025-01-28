import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod/riverpod.dart';

final connectivityProvider = StreamProvider<bool>((ref) async* {
  final internetConnection = InternetConnection();
  await for (final status in internetConnection.onStatusChange) {
    yield status ==
        InternetStatus.connected; // Emit true if connected, false otherwise
  }
});

class ConnectivityStatusNotifier extends Notifier<bool> {
  late InternetConnection _internetConnection;

  @override
  bool build() {
    _internetConnection = InternetConnection();
    final stream = _internetConnection.onStatusChange.listen(_statusListener);

    ref.onDispose(() {
      stream.cancel();
    });

    return false;
  }

  void _statusListener(InternetStatus status) {
    switch (status) {
      case InternetStatus.connected:
        state = true;
      case InternetStatus.disconnected:
        state = false;
    }
  }
}
