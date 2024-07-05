import 'package:finance_tracker/features/profile_management/presentation/bloc/profile_bloc.dart';

import 'package:finance_tracker/features/security/presentation/bloc/biometric_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/app.dart';
import 'package:finance_tracker/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:finance_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_tracker/init_dependecies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      
      ),
       BlocProvider(
        create: (_) => serviceLocator<ProfileBloc>(),
      ),
      BlocProvider(create: (_) => serviceLocator<BiometricBloc>(),)
       
    ],
    child: const MainApp(),
  ));
  
}