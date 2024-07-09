// lib/core/services/auth_service.dart
import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool isBiometricSupported = await auth.isDeviceSupported();

      if (canAuthenticateWithBiometrics && isBiometricSupported) {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please unlock to access',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
        return didAuthenticate;
      }
    } catch (e) {
      print('Error during biometric authentication: $e');
    }
    return false;
  }
}
