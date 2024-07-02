import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/auth/domain/entities/user.dart';
import 'package:finance_tracker/features/profile_management/data/datasources/user_remote_datasource.dart';
import 'package:finance_tracker/features/profile_management/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String,List< User>>> getUserProfile() async {
    try {
      final profile = await remoteDataSource.getUserProfile();
      return Right(profile);
    } catch (e) {
      return left(e.toString());
    }
  }
}
