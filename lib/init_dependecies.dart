import 'package:get_it/get_it.dart';
import 'package:new_blogger/core/secrets/app_secrets.dart';
import 'package:new_blogger/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:new_blogger/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:new_blogger/features/auth/domain/repository/auth_repository.dart';
import 'package:new_blogger/features/auth/domain/usecases/user_login.dart';
import 'package:new_blogger/features/auth/domain/usecases/user_sign_up.dart';
import 'package:new_blogger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonyKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
    ),
  );
}
