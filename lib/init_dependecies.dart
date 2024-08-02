<<<<<<< HEAD
import 'package:finance_tracker/core/services/currency_service.dart';
import 'package:finance_tracker/core/services/shared_preferences_service.dart';
import 'package:finance_tracker/features/ai_automation/data/api_service.dart';
import 'package:finance_tracker/features/ai_automation/presentation/bloc/ai_bloc.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_up.dart';
import 'package:finance_tracker/features/currency_conversion/data/repositories/currency_repository_impl.dart';
import 'package:finance_tracker/features/currency_conversion/domain/repositories/currency_repository.dart';
import 'package:finance_tracker/features/currency_conversion/domain/usecases/get_currency_rates.dart';
import 'package:finance_tracker/features/currency_conversion/presentation/bloc/currency_bloc.dart';
=======
import 'package:finance_tracker/core/services/one_signal.dart';
import 'package:finance_tracker/features/ai_automation/data/api_service.dart';
import 'package:finance_tracker/features/ai_automation/presentation/bloc/ai_bloc.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_up.dart';
import 'package:finance_tracker/features/bill_payment/data/repositories/bill_repository_impl.dart';
import 'package:finance_tracker/features/bill_payment/domain/usecases/get_all_bills.dart';
import 'package:finance_tracker/features/bill_payment/domain/usecases/set_bill_reminder.dart';
import 'package:finance_tracker/features/bill_payment/presentation/blocs/bill_bloc.dart';
import 'package:finance_tracker/features/bill_payment/presentation/blocs/bill_state.dart';
import 'package:finance_tracker/features/finance/domain/usecases/manage_transactions.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/transaction_bloc.dart';
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0
import 'package:finance_tracker/features/finance_blog/data/datasources/blog_local_datasource.dart';
import 'package:finance_tracker/features/finance_blog/data/datasources/blog_remote_data_source.dart';
import 'package:finance_tracker/features/finance_blog/data/repositories/blog_repository_impl.dart';
import 'package:finance_tracker/features/finance_blog/domain/repositories/blog_repositories.dart';
import 'package:finance_tracker/features/finance_blog/domain/usecases/get_all_blogs.dart';
import 'package:finance_tracker/features/finance_blog/domain/usecases/upload_blog.dart';
import 'package:finance_tracker/features/finance_blog/presentation/bloc/blog_bloc.dart';
import 'package:finance_tracker/features/notifications_events/data/repositories/financial_repository_impl.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/financial_repository.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/check_spending_trend.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_category_total.dart';
import 'package:finance_tracker/features/notifications_events/presentation/providers/financial_provider.dart';
import 'package:finance_tracker/features/notifications_events/presentation/services/notification_service.dart';
import 'package:finance_tracker/features/security/domain/usecases/get_biometric_status.dart';
import 'package:finance_tracker/features/security/domain/usecases/set_biometric_status.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:finance_tracker/core/network/network_connection_checker.dart';
import 'package:finance_tracker/core/utils/notification_helper.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_up_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_out.dart';
import 'package:finance_tracker/features/finance/data/datasources/transaction_local_data_source.dart';
import 'package:finance_tracker/features/finance/data/repositories/transaction_repository_impl.dart';
import 'package:finance_tracker/features/finance/domain/repositories/finance_transaction_repository.dart';
<<<<<<< HEAD
import 'package:finance_tracker/features/finance/domain/usecases/add_finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/delete_finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/get_finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/update_finance_transaction.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/finance_transaction_bloc.dart';
=======
import 'package:finance_tracker/features/notifications_events/data/repositories/event_repository_impl.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/event_repository.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/add_event.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_all_events.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_balance.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/update_balance.dart';
import 'package:finance_tracker/features/notifications_events/presentation/bloc/balance_bloc.dart';
import 'package:finance_tracker/features/notifications_events/presentation/bloc/event_bloc.dart';
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0
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
<<<<<<< HEAD
  _initCurrency();
=======
  _initBill();
  // _initOneSignal();
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0

  await NotificationHelper.initialize();
}

Future<void> _initCoreDependencies() async {
  // Initialize Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonyKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  // init onesignal
  final oneSignalService = OneSignalService();
  oneSignalService.initialize(dotenv.env['ONESIGNALID']!);

  serviceLocator.registerLazySingleton<OneSignalService>(() => oneSignalService);


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
  serviceLocator.registerLazySingleton(() => SharedPreferencesService());
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
  // services
  serviceLocator
    .registerLazySingleton<NotificationService>(
      () => NotificationService( serviceLocator()),
    );
  // Repositories
  serviceLocator
    .registerLazySingleton<FinancialRepository>(
      () => FinancialRepositoryImpl( serviceLocator()),
    );


  // Use cases
  serviceLocator
    ..registerLazySingleton(() => GetCategoryTotal(serviceLocator()))
    ..registerLazySingleton(() => CheckSpendingTrend(serviceLocator()));


  // Providers
  serviceLocator
    .registerFactory(() => FinancialProvider(
      checkSpendingTrend:serviceLocator(),
      getCategoryTotal:serviceLocator(),
      notificationService:serviceLocator(),
      financialRepository:serviceLocator(),
      ));
   
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

<<<<<<< HEAD
void _initCurrency() {
  // Currency Repository
  serviceLocator.registerFactory<CurrencyRepository>(
      () => CurrencyRepositoryImpl(serviceLocator()));

  // Currency UseCase
  serviceLocator.registerFactory(() => GetCurrencyRates(serviceLocator()));

  // Currency Bloc
  serviceLocator.registerLazySingleton(
      () => CurrencyBloc(
         serviceLocator()));
  // Register CurrencyService
  serviceLocator.registerLazySingleton<CurrencyService>(() => CurrencyService());
  
}
=======
void _initBill() {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Register the BillRepository
  serviceLocator.registerLazySingleton(() => BillRepositoryImpl(flutterLocalNotificationsPlugin));

  // Register use cases
  serviceLocator.registerLazySingleton(() => GetAllBills(serviceLocator<BillRepositoryImpl>()));
  serviceLocator.registerLazySingleton(() => SetBillReminder(serviceLocator<BillRepositoryImpl>()));

  // Register the BillBloc
  serviceLocator.registerFactory(() => BillBloc(
    initialState: BillLoading(),
    getAllBills: serviceLocator<GetAllBills>(),
    setBillReminder: serviceLocator<SetBillReminder>(),
  ));
}



  // void _initOneSignal() {
  //   OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
  //     // Handle notification received
  //     print('Notification received: ${notification.jsonRepresentation()}');
  //   });

  //   OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     // Handle notification opened
  //     print('Notification opened: ${result.notification.jsonRepresentation()}');
  //   });
  // }
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0
