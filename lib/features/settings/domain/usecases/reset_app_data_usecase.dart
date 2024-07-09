import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/settings/domain/repositories/app_repository.dart';
import 'package:fpdart/fpdart.dart';

class ResetAppDataUsecase {
  final ResetAppRepository repository;
  ResetAppDataUsecase(this.repository);

  Future<Either<Failure, Unit>> call() {
    return repository.resetAppData();
  }
}
