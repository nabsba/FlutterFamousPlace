import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  // ignore: unrelated_type_equality_checks
  return connectivityResult == ConnectivityResult.mobile ||
      // ignore: unrelated_type_equality_checks
      connectivityResult == ConnectivityResult.wifi;
}
