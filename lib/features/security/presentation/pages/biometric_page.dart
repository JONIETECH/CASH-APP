// lib/features/authentication/presentation/pages/biometric_login_page.dart
import 'package:finance_tracker/features/finance/presentation/pages/dashboardpage.dart';
import 'package:flutter/material.dart';
import '../widgets/auth_button.dart';

class BiometricLoginPage extends StatefulWidget {
  const BiometricLoginPage({super.key});

  @override
  State<BiometricLoginPage> createState() => _BiometricLoginPageState();
}

class _BiometricLoginPageState extends State<BiometricLoginPage> {
  bool _isAuthenticated = false;

  void _onAuthenticated(bool isAuthenticated) {
    setState(() {
      _isAuthenticated = isAuthenticated;
    });

    if (_isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'My Account Initials',
              style: TextStyle(color: Colors.blue, fontSize: 30),
            ),
            if (_isAuthenticated)
              const Text('Authenticated')
            else
              const Text('Not Authenticated'),
          ],
        ),
      ),
      floatingActionButton: AuthButton(onAuthenticated: _onAuthenticated),
    );
  }
}
