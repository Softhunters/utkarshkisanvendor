
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectivityNotifier {
  final ValueNotifier<bool> isConnected = ValueNotifier<bool>(true);
  late StreamSubscription _subscription;

  ConnectivityNotifier() {
    _subscription = Connectivity().onConnectivityChanged.listen((_) => _checkConnection());
    _checkConnection(); // Initial check
  }

  Future<void> _checkConnection() async {
    try {
      final result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        isConnected.value = false;
        return;
      }

      final response = await http.get(Uri.parse("https://www.google.com")).timeout(Duration(seconds: 5));
      isConnected.value = response.statusCode == 200;
    } catch (e) {
      isConnected.value = false;
    }
  }

  Future<void> retry() => _checkConnection();

  void dispose() {
    _subscription.cancel();
    isConnected.dispose();
  }
}
