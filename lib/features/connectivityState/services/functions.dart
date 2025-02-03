import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  final Connectivity _connectivity = Connectivity();

  /// Checks if there is an active internet connection (Wi-Fi or Mobile).
  Future<bool> hasInternetConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  /// Checks if the device is connected via Wi-Fi.
  Future<bool> isConnectedToWiFi() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.wifi;
  }

  /// Checks if the device is connected via Mobile Data.
  Future<bool> isConnectedToMobileData() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile;
  }

  /// Checks if the device is connected via Bluetooth.
  Future<bool> isConnectedToBluetooth() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.bluetooth;
  }

  /// Checks if the device is connected via Ethernet.
  Future<bool> isConnectedToEthernet() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.ethernet;
  }

  /// Checks if the device is connected via VPN.
  Future<bool> isConnectedToVPN() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.vpn;
  }

  /// Checks if the device is connected to an unknown network type.
  Future<bool> isConnectedToUnknown() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.other;
  }

  /// Checks if there is no connection available.
  Future<bool> hasNoConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.none;
  }

  /// Returns the current connectivity type as a string.
  Future<String> getConnectivityType() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    switch (connectivityResult) {
      // ignore: constant_pattern_never_matches_value_type
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      // ignore: constant_pattern_never_matches_value_type
      case ConnectivityResult.wifi:
        return 'Wi-Fi';
      // ignore: constant_pattern_never_matches_value_type
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      // ignore: constant_pattern_never_matches_value_type
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      // ignore: constant_pattern_never_matches_value_type
      case ConnectivityResult.vpn:
        return 'VPN';
      // ignore: constant_pattern_never_matches_value_type
      case ConnectivityResult.other:
        return 'Unknown Network';
      // ignore: constant_pattern_never_matches_value_type
      case ConnectivityResult.none:
        return 'No Connection';
      default:
        return 'Unknown Status';
    }
  }
}
