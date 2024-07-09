import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/security/domain/entities/biometric_status.dart';
import 'package:finance_tracker/features/security/domain/repositories/biometric_repository.dart';
import 'package:fpdart/fpdart.dart';


class GetBiometricStatus implements UseCase<BiometricStatus, NoParams> {
  final BiometricRepository repository;

  GetBiometricStatus(this.repository);

  @override
  Future<Either<Failure, BiometricStatus>> call(NoParams params) async {
    return await repository.getBiometricStatus();
  }
}
