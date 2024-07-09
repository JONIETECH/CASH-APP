import 'package:finance_tracker/core/network/network_connection_checker.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_up_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_out.dart';
import 'package:finance_tracker/features/finance/data/datasources/finance_local_data_source.dart';
import 'package:finance_tracker/features/finance/data/repositories/finance_transaction_repository_impl.dart';
import 'package:finance_tracker/features/finance/domain/repositories/finance_transaction_repository.dart';
import 'package:finance_tracker/features/finance/domain/usecases/add_finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/delete_finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/get_finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/update_finance_transaction.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/finance_transaction_bloc.dart';

import 'package:finance_tracker/features/security/data/datasources/biometric_local_datasource.dart';
import 'package:finance_tracker/features/security/data/repositories/biometric_repository_impl.dart';
import 'package:finance_tracker/features/security/domain/repositories/biometric_repository.dart';
import 'package:finance_tracker/features/security/domain/usecases/authenticate.dart';
import 'package:finance_tracker/features/security/domain/usecases/get_biometric_status.dart';
import 'package:finance_tracker/features/security/domain/usecases/set_biometric_status.dart';
import 'package:finance_tracker/features/security/presentation/bloc/biometric_bloc.dart';
import 'package:finance_tracker/features/settings/data/repositories/reset_app_repository_impl.dart';
import 'package:finance_tracker/features/settings/domain/repositories/app_repository.dart';
import 'package:finance_tracker/features/settings/domain/usecases/reset_app_data_usecase.dart';
import 'package:finance_tracker/features/settings/presentation/bloc/reset_bloc.dart';
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

// Initialize GetIt instance
final serviceLocator = GetIt.instance;

// Function to initialize all dependencies
Future<void> initDependencies() async {
  // Initialize feature-specific dependencies
  _initAuth(); // Authentication
  //_initProfile(); // Profile Management
  _initBiometric(); // Biometric Authentication
  _initTheme(); // Theme Management
  _initFinanceTransactions(); // Finance Transactions
  _initReset(); // Reset App Data

  // Initialize Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonyKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // Register Internet Connection
  serviceLocator.registerFactory(() => InternetConnection());

  // Register GoogleSignIn
  serviceLocator.registerLazySingleton(() => GoogleSignIn());

  // Core dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  // Register Connection Checker
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );

  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
}

// Initialize authentication related dependencies
void _initAuth() {
  serviceLocator
    // Register Auth Remote Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator(), serviceLocator()),
    )
    // Register Auth Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    // Register Use Cases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerFactory(() => UserSignOut(serviceLocator()))
    ..registerFactory(() => SignInWithGoogle(serviceLocator()))
    ..registerFactory(() => SignUpWithGoogle(serviceLocator()))
    // Register Auth Bloc
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

// Initialize profile management related dependencies
//
// Initialize biometric related dependencies
void _initBiometric() {
  final localAuth = LocalAuthentication();

  serviceLocator
    // Register Biometric Local Data Source
    ..registerFactory<BiometricLocalDataSource>(
      () => BiometricLocalDataSourceImpl(
        localAuth: localAuth,
        sharedPreferences: serviceLocator(),
      ),
    )
    // Register Biometric Repository
    ..registerFactory<BiometricRepository>(
      () => BiometricRepositoryImpl(localDataSource: serviceLocator()),
    )
    // Register Use Cases
    ..registerFactory(() => Authenticate(serviceLocator()))
    ..registerFactory(() => GetBiometricStatus(serviceLocator()))
    ..registerFactory(() => SetBiometricStatus(serviceLocator()))
    // Register Biometric Bloc
    ..registerLazySingleton(
      () => BiometricBloc(
        getBiometricStatus: serviceLocator(),
        setBiometricStatus: serviceLocator(),
        authenticate: serviceLocator(),
      ),
    );
}

// Initialize theme related dependencies
void _initTheme() {
  serviceLocator.registerLazySingleton(
    () => ThemeBloc(sharedPreferences: serviceLocator()),
  );
}

// Initialize finance transactions related dependencies
void _initFinanceTransactions() {
  serviceLocator
    // Register Finance Local Data Source
    ..registerFactory<FinanceLocalDataSource>(
      () => FinanceLocalDataSourceImpl(serviceLocator()),
    )
    // Register Finance Transaction Repository
    ..registerFactory<FinanceTransactionRepository>(
      () => FinanceTransactionRepositoryImpl(
        financeLocalDataSource: serviceLocator(),
      ),
    )
    // Register Use Cases
    ..registerFactory(() => AddFinanceTransaction(serviceLocator()))
    ..registerFactory(() => DeleteFinanceTransaction(serviceLocator()))
    ..registerFactory(() => GetFinanceTransactions(serviceLocator()))
    ..registerFactory(() => UpdateFinanceTransaction(serviceLocator()))
    // Register Finance Transaction Bloc
    ..registerFactory(
      () => FinanceTransactionBloc(
        getFinanceTransactions: serviceLocator(),
        addFinanceTransaction: serviceLocator(),
        updateFinanceTransaction: serviceLocator(),
        deleteFinanceTransaction: serviceLocator(),
      ),
    );
}

// Initialize reset app data related dependencies
void _initReset() {
  serviceLocator
    // Register Reset App Repository
    ..registerFactory<ResetAppRepository>(
      () => ResetAppRepositoryImpl(
        serviceLocator(),
        serviceLocator(),

      ),
    )
    // Register Reset App Data Usecase
    ..registerFactory(
      () => ResetAppDataUsecase(
        serviceLocator(),
      ),
    )
    // Register Reset Bloc
    ..registerFactory(
      () => ResetBloc(
        resetAppDataUsecase: serviceLocator(),
      ),
    );
}
