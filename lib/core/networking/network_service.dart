import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Service to monitor and check network connectivity status
class NetworkService {
  // Singleton pattern
  NetworkService._();
  static final NetworkService _instance = NetworkService._();
  static NetworkService get instance => _instance;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  /// Check if device has active internet connection
  Future<bool> isConnected() async {
    try {
      final List<ConnectivityResult> connectivityResult = await _connectivity
          .checkConnectivity();

      // Check if any of the results indicate connectivity
      return connectivityResult.any(
        (result) =>
            result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi ||
            result == ConnectivityResult.ethernet ||
            result == ConnectivityResult.vpn,
      );
    } catch (e) {
      // If we can't determine connectivity, assume we're offline
      return false;
    }
  }

  /// Get current connectivity status
  Future<List<ConnectivityResult>> getConnectivityStatus() async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      return [ConnectivityResult.none];
    }
  }

  /// Listen to connectivity changes
  /// Returns a stream that emits connectivity status updates
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }

  /// Initialize connectivity monitoring (optional - for future use)
  void initConnectivityMonitoring({
    required Function(bool isConnected) onConnectivityChange,
  }) {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final isConnected = results.any(
        (result) =>
            result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi ||
            result == ConnectivityResult.ethernet ||
            result == ConnectivityResult.vpn,
      );
      onConnectivityChange(isConnected);
    });
  }

  /// Dispose connectivity monitoring
  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
