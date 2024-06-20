import 'package:flutter/material.dart';
import 'package:new_blogger/core/theme/theme.dart';
import 'package:new_blogger/features/auth/presentation/pages/login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
