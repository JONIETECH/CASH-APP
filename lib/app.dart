import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_blogger/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:new_blogger/core/theme/theme.dart';
import 'package:new_blogger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:new_blogger/features/auth/presentation/pages/login_page.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
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
            return const Scaffold(
              body: Center(child: Text('Logged in')),
            );
          }
          return const LoginPage();
        },
      ),
    );
  }
}
