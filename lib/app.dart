import 'package:finance_tracker/features/finance/presentation/pages/dashboardpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:finance_tracker/core/theme/theme.dart';
import 'package:finance_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:get_it/get_it.dart';
import 'package:finance_tracker/features/security/data/datasources/biometric_local_datasource.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    _checkBiometricAuth();
  }

  Future<void> _checkBiometricAuth() async {
    final biometricLocalDataSource = GetIt.instance<BiometricLocalDataSource>();
    final biometricEnabled = await biometricLocalDataSource.getBiometricStatus();

    if (biometricEnabled) {
      final authenticated = await biometricLocalDataSource.authenticate();
      if (!authenticated) {
        // If biometric authentication fails, handle it here
        // Navigate to the login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
        _showAuthenticationFailedDialog();
      }
    }
  }

  void _showAuthenticationFailedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Authentication Failed'),
          content: const Text('Biometric authentication failed. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash App',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const DashboardPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
