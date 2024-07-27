import 'package:finance_tracker/features/ai_automation/data/api_service.dart';
import 'package:finance_tracker/features/ai_automation/presentation/bloc/ai_bloc.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_up.dart';
import 'package:finance_tracker/features/finance/domain/usecases/manage_transactions.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/transaction_bloc.dart';
import 'package:finance_tracker/features/finance_blog/data/datasources/blog_local_datasource.dart';
import 'package:finance_tracker/features/finance_blog/data/datasources/blog_remote_data_source.dart';
import 'package:finance_tracker/features/finance_blog/data/repositories/blog_repository_impl.dart';
import 'package:finance_tracker/features/finance_blog/domain/repositories/blog_repositories.dart';
import 'package:finance_tracker/features/finance_blog/domain/usecases/get_all_blogs.dart';
import 'package:finance_tracker/features/finance_blog/domain/usecases/upload_blog.dart';
import 'package:finance_tracker/features/finance_blog/presentation/bloc/blog_bloc.dart';
import 'package:finance_tracker/features/notifications_events/data/datasources/balance_local_data_source.dart';
import 'package:finance_tracker/features/notifications_events/data/datasources/balance_local_data_source_impl.dart';
import 'package:finance_tracker/features/notifications_events/data/datasources/event_local_data_source.dart';
import 'package:finance_tracker/features/notifications_events/data/datasources/event_local_data_source_impl.dart';
import 'package:finance_tracker/features/notifications_events/data/repositories/balance_repository_impl.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/balance_repository.dart';
import 'package:finance_tracker/features/security/domain/usecases/get_biometric_status.dart';
import 'package:finance_tracker/features/security/domain/usecases/set_biometric_status.dart';
import 'package:get_it/get_it.dart';
import 'package:finance_tracker/core/network/network_connection_checker.dart';
import 'package:finance_tracker/core/utils/notification_helper.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_up_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_out.dart';
import 'package:finance_tracker/features/finance/data/datasources/transaction_local_data_source.dart';
import 'package:finance_tracker/features/finance/data/repositories/transaction_repository_impl.dart';
import 'package:finance_tracker/features/finance/domain/repositories/finance_transaction_repository.dart';
import 'package:finance_tracker/features/notifications_events/data/repositories/event_repository_impl.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/event_repository.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/add_event.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_all_events.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_balance.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/update_balance.dart';
import 'package:finance_tracker/features/notifications_events/presentation/bloc/balance_bloc.dart';
import 'package:finance_tracker/features/notifications_events/presentation/bloc/event_bloc.dart';
import 'package:finance_tracker/features/security/data/datasources/biometric_local_datasource.dart';
import 'package:finance_tracker/features/security/data/repositories/biometric_repository_impl.dart';
import 'package:finance_tracker/features/security/domain/repositories/biometric_repository.dart';
import 'package:finance_tracker/features/security/domain/usecases/authenticate.dart';
import 'package:finance_tracker/features/security/presentation/bloc/biometric_bloc.dart';
import 'package:finance_tracker/features/settings/data/repositories/reset_app_repository_impl.dart';
import 'package:finance_tracker/features/settings/domain/repositories/app_repository.dart';
import 'package:finance_tracker/features/settings/domain/usecases/reset_app_data_usecase.dart';
import 'package:finance_tracker/features/settings/presentation/bloc/reset_bloc.dart';
import 'package:finance_tracker/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:finance_tracker/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:finance_tracker/core/secrets/app_secrets.dart';
import 'package:finance_tracker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:finance_tracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:finance_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:finance_tracker/features/auth/domain/usecases/current_user.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_login.dart';
import 'package:finance_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initCoreDependencies();
  _initAuth();
  _initBiometric();
  _initTheme();
  _initFinanceTransactions();
  _initReset();
  _initNotifications();
  _initAI();
  _initBlog();

  await NotificationHelper.initialize();
}

Future<void> _initCoreDependencies() async {
  // Initialize Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonyKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //hive
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));

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

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerFactory(() => UserSignOut(serviceLocator()))
    ..registerFactory(() => SignInWithGoogle(serviceLocator()))
    ..registerFactory(() => SignUpWithGoogle(serviceLocator()))
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

void _initBiometric() {
  final localAuth = LocalAuthentication();

  serviceLocator
    ..registerFactory<BiometricLocalDataSource>(
      () => BiometricLocalDataSourceImpl(
        localAuth: localAuth,
        sharedPreferences: serviceLocator(),
      ),
    )
    ..registerFactory<BiometricRepository>(
      () => BiometricRepositoryImpl(localDataSource: serviceLocator()),
    )
    ..registerFactory(() => Authenticate(serviceLocator()))
    ..registerFactory(() => GetBiometricStatus(serviceLocator()))
    ..registerFactory(() => SetBiometricStatus(serviceLocator()))
    ..registerLazySingleton(
      () => BiometricBloc(
        getBiometricStatus: serviceLocator(),
        setBiometricStatus: serviceLocator(),
        authenticate: serviceLocator(),
      ),
    );
}

void _initTheme() {
  serviceLocator.registerLazySingleton(
    () => ThemeBloc(sharedPreferences: serviceLocator()),
  );
}

void _initFinanceTransactions() {
  serviceLocator
  //datasource
    ..registerFactory<TransactionLocalDataSource>(
      () => TransactionLocalDataSourceImpl(
        
        sharedPreferences:  serviceLocator(),
      ))
         
        
    
    ..registerFactory<TransactionRepository>(
      () =>TransactionRepositoryImpl(
       localDataSource: serviceLocator(),
      ),
    )
    //usecases
    ..registerFactory(() => AddTransaction(serviceLocator()))
    ..registerFactory(() => DeleteTransaction(serviceLocator()))
    ..registerFactory(() => GetTransactions(serviceLocator()))
    ..registerFactory(() => UpdateTransaction(serviceLocator()))
    ..registerFactory(
      () => TransactionBloc(
        getTransactions: serviceLocator(),
        addTransaction: serviceLocator(),
        updateTransaction: serviceLocator(),
        deleteTransaction: serviceLocator(),
      ),
    );
}

void _initReset() {
  serviceLocator
    ..registerFactory<ResetAppRepository>(
      () => ResetAppRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ResetAppDataUsecase(serviceLocator()),
    )
    ..registerFactory(
      () => ResetBloc(
        resetAppDataUsecase: serviceLocator(),
      ),
    );
}

void _initNotifications() {
  // Data sources
  serviceLocator
    ..registerLazySingleton<EventLocalDataSource>(
      () => EventLocalDataSourceImpl(sharedPreferences: serviceLocator()),
    )
    ..registerLazySingleton<BalanceLocalDataSource>(
      () => BalanceLocalDataSourceImpl(sharedPreferences: serviceLocator()),
    );

  // Repositories
  serviceLocator
    ..registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(localDataSource: serviceLocator()),
    )
    ..registerLazySingleton<BalanceRepository>(
      () => BalanceRepositoryImpl(localDataSource: serviceLocator()),
    );

  // Use cases
  serviceLocator
    ..registerLazySingleton(() => GetAllEvents(serviceLocator()))
    ..registerLazySingleton(() => AddEvent(serviceLocator()))
    ..registerLazySingleton(() => GetBalance(serviceLocator()))
    ..registerLazySingleton(() => UpdateBalance(serviceLocator()));

  // BLoCs
  serviceLocator
    ..registerFactory(
      () => EventBloc(
        getAllEvents: serviceLocator(),
        addEvent: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => BalanceBloc(
        getBalance: serviceLocator(),
        updateBalance: serviceLocator(),
      ),
    );
}

void _initAI() {
  serviceLocator
    ..registerSingleton<ApiService>(ApiService())
    ..registerFactory(() => AiBloc(apiService: serviceLocator()));
}

void _initBlog() {
  serviceLocator
    //Datasource
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDatasourceImpl(serviceLocator()))
    //repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )

    //usecase
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )

    //Blocs
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
