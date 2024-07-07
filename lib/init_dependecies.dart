import 'package:finance_tracker/core/network/network_connection_checker.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_up_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_out.dart';
import 'package:finance_tracker/features/profile_management/data/datasources/user_remote_datasource.dart';
import 'package:finance_tracker/features/profile_management/data/repositories/profile_repository_impl.dart';
import 'package:finance_tracker/features/profile_management/domain/repositories/user_repository.dart';
import 'package:finance_tracker/features/profile_management/domain/usecases/get_user_profile.dart';
import 'package:finance_tracker/features/profile_management/presentation/bloc/profile_bloc.dart';
import 'package:finance_tracker/features/security/data/datasources/biometric_local_datasource.dart';
import 'package:finance_tracker/features/security/data/repositories/biometric_repository_impl.dart';
import 'package:finance_tracker/features/security/domain/repositories/biometric_repository.dart';
import 'package:finance_tracker/features/security/domain/usecases/authenticate.dart';
import 'package:finance_tracker/features/security/domain/usecases/get_biometric_status.dart';
import 'package:finance_tracker/features/security/domain/usecases/set_biometric_status.dart';
import 'package:finance_tracker/features/security/presentation/bloc/biometric_bloc.dart';
import 'package:finance_tracker/features/settings/presentation/bloc/theme_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:finance_tracker/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:finance_tracker/core/secrets/app_secrets.dart';
import 'package:finance_tracker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:finance_tracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:finance_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:finance_tracker/features/auth/domain/usecases/current_user.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_login.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_up.dart';
import 'package:finance_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initProfile();
  _initBiometric();
  _initTheme();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonyKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => GoogleSignIn());
  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  // registr googleSignIn
}

void _initAuth() {
  //DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      //repositpry
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )

    ///Use Cases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignOut(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignInWithGoogle(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignUpWithGoogle(
        serviceLocator(),
      ),
    )

    ///Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        currentUser: serviceLocator(),
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        appUserCubit: serviceLocator(),
        userSignOut: serviceLocator(),
        signInWithGoogle: serviceLocator(),
        signUpWithGoogle: serviceLocator(),
      ),
    );
}

void _initProfile() {
  // Data Source
  serviceLocator.registerFactory<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<ProfileRepository>(
    () => ProfileRepositoryImpl(
      serviceLocator(),
    ),
  );

  // Use Case
  serviceLocator.registerFactory(
    () => GetUserProfile(
      serviceLocator(),
    ),
  );

  // Bloc
  serviceLocator.registerFactory(
    () => ProfileBloc(
      getUserProfile: serviceLocator(),
    ),
  );
}

void _initBiometric() {
  // Initialize LocalAuthentication
  final localAuth = LocalAuthentication();

  // Data Source
  serviceLocator.registerFactory<BiometricLocalDataSource>(
    () => BiometricLocalDataSourceImpl(
      localAuth: localAuth,
      sharedPreferences: serviceLocator(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<BiometricRepository>(
    () => BiometricRepositoryImpl(
      localDataSource: serviceLocator(),
    ),
  );

  // Use Cases
  serviceLocator.registerFactory(
    () => Authenticate(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetBiometricStatus(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => SetBiometricStatus(
      serviceLocator(),
    ),
  );

  // Bloc
  serviceLocator.registerLazySingleton(
    () => BiometricBloc(
      getBiometricStatus: serviceLocator(),
      setBiometricStatus: serviceLocator(),
      authenticate: serviceLocator(),
    ),
  );
}

void _initTheme() {
  //blocs
  serviceLocator.registerLazySingleton(
    () => ThemeBloc(
      sharedPreferences: serviceLocator(),
    ),
  );
}
