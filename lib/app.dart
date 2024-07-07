import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/finance/presentation/pages/dashboardpage.dart';
import 'features/security/data/datasources/biometric_local_datasource.dart';
import 'features/security/presentation/bloc/biometric_bloc.dart';
import 'features/settings/presentation/bloc/theme_bloc.dart';
import 'core/theme/theme.dart';
import 'core/common/cubits/app_user/app_user_cubit.dart';

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
    context.read<ThemeBloc>().add(LoadThemeStatus());
    _checkBiometricAuth();
  }

  Future<void> _checkBiometricAuth() async {
    final biometricLocalDataSource = GetIt.instance<BiometricLocalDataSource>();
    final biometricEnabled =
        await biometricLocalDataSource.getBiometricStatus();

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
          content:
              const Text('Biometric authentication failed. Please try again.'),
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
    return MultiBlocListener(
      listeners: [
        BlocListener<BiometricBloc, BiometricState>(
          listener: (context, state) {
            if (state is BiometricLoaded) {
              // Handle any updates based on the biometric state if necessary
            }
          },
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cash App',
            themeMode: (state as ThemeInitial).themeMode,
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
        },
      ),
    );
  }
}
