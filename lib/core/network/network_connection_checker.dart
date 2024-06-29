import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;
  late final StreamSubscription<InternetStatus> _listener;

  ConnectionCheckerImpl(this.internetConnection) {
    _listener = internetConnection.onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          // Handle the internet connected state
          break;
        case InternetStatus.disconnected:
          // Handle the internet disconnected state
          break;
      }
    });
  }

  @override
  Future<bool> get isConnected async => await internetConnection.hasInternetAccess;

  void dispose() {
    _listener.cancel();
  }
}
