import 'package:fpdart/fpdart.dart';
import 'package:new_blogger/core/error/exceptions.dart';
import 'package:new_blogger/core/error/failure.dart';
import 'package:new_blogger/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:new_blogger/features/auth/domain/entities/user.dart';
import 'package:new_blogger/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,User >> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
