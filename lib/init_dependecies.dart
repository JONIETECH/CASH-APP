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
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonyKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  //DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      //repositpry
      () => AuthRepositoryImpl(
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

    ///Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        currentUser: serviceLocator(),
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
