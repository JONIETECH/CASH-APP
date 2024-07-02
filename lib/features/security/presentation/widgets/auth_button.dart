// lib/features/authentication/presentation/widgets/auth_button.dart
import 'package:flutter/material.dart';
import '../../../../core/services/auth_service.dart';

class AuthButton extends StatefulWidget {
  final Function(bool) onAuthenticated;

  const AuthButton({Key? key, required this.onAuthenticated}) : super(key: key);

  @override
  _AuthButtonState createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _isAuthenticated = false;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        if (!_isAuthenticated) {
          bool didAuthenticate = await _authService.authenticate();
          setState(() {
            _isAuthenticated = didAuthenticate;
          });
          widget.onAuthenticated(didAuthenticate);
        } else {
          setState(() {
            _isAuthenticated = false;
          });
          widget.onAuthenticated(false);
        }
      },
      child: Icon(_isAuthenticated ? Icons.lock : Icons.lock_open),
    );
  }
}
