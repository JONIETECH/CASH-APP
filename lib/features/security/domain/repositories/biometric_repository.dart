import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/security/domain/entities/biometric_status.dart';
import 'package:fpdart/fpdart.dart';


abstract class BiometricRepository {
  Future<Either<Failure, BiometricStatus>> getBiometricStatus();
  Future<Either<Failure, void>> setBiometricStatus(bool status);
  Future<Either<Failure, bool>> authenticate();
}
