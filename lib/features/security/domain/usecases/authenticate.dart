import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/security/domain/repositories/biometric_repository.dart';
import 'package:fpdart/fpdart.dart';


class Authenticate implements UseCase<bool, NoParams> {
  final BiometricRepository repository;

  Authenticate(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.authenticate();
  }
}
