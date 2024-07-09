import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/security/data/datasources/biometric_local_datasource.dart';
import 'package:finance_tracker/features/security/domain/entities/biometric_status.dart';
import 'package:finance_tracker/features/security/domain/repositories/biometric_repository.dart';
import 'package:fpdart/fpdart.dart';


class BiometricRepositoryImpl implements BiometricRepository {
  final BiometricLocalDataSource localDataSource;

  BiometricRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, BiometricStatus>> getBiometricStatus() async {
    try {
      final status = await localDataSource.getBiometricStatus();
      return Right(BiometricStatus(isEnabled: status));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setBiometricStatus(bool status) async {
    try {
      await localDataSource.setBiometricStatus(status);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> authenticate() async {
    try {
      final authenticated = await localDataSource.authenticate();
      return Right(authenticated);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
