import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/security/domain/repositories/biometric_repository.dart';
import 'package:fpdart/fpdart.dart';


class SetBiometricStatus implements UseCase<void, bool> {
  final BiometricRepository repository;

  SetBiometricStatus(this.repository);

  @override
  Future<Either<Failure, void>> call(bool status) async {
    return await repository.setBiometricStatus(status);
  }
}
