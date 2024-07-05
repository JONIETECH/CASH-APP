import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BiometricLocalDataSource {
  Future<bool> getBiometricStatus();
  Future<void> setBiometricStatus(bool status);
  Future<bool> authenticate();
}

class BiometricLocalDataSourceImpl implements BiometricLocalDataSource {
  final LocalAuthentication localAuth;
  final SharedPreferences sharedPreferences;

  BiometricLocalDataSourceImpl({
    required this.localAuth,
    required this.sharedPreferences,
  });

  static const CACHED_BIOMETRIC_STATUS = 'CACHED_BIOMETRIC_STATUS';

  @override
  Future<bool> getBiometricStatus() async {
    return sharedPreferences.getBool(CACHED_BIOMETRIC_STATUS) ?? false;
  }

  @override
  Future<void> setBiometricStatus(bool status) async {
    sharedPreferences.setBool(CACHED_BIOMETRIC_STATUS, status);
  }

  @override
  Future<bool> authenticate() async {
    return await localAuth.authenticate(
      localizedReason: 'Please authenticate to use biometric login',
    );
  }
}
