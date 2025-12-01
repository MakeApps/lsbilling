// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'dart:async';

// class NetworkCheck {
//   Future<bool> isInternetConnected() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi;
//   }
//   // To listen for real-time changes in connectivity
//   StreamSubscription<ConnectivityResult> monitorConnection(
//       Function(ConnectivityResult) onConnectionChange) {
//     return Connectivity().onConnectivityChanged.listen(onConnectionChange);
//   }
// }
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class NetworkCheck {
  Future<bool> isInternetConnected() async {
    final connectivityResults = await Connectivity().checkConnectivity();
    // Since it's now a List, check if it contains WiFi or Mobile
    return connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.wifi);
  }

  StreamSubscription<List<ConnectivityResult>> monitorConnection(
    void Function(ConnectivityResult) onConnectionChange,
  ) {
    return Connectivity().onConnectivityChanged.listen((results) {
      if (results.isNotEmpty) {
        // Take the most recent (last) connectivity status
        onConnectionChange(results.last);
      }
    });
  }
}
