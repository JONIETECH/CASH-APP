import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/balance.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/balance_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateBalance implements UseCase<void, Balance> {
  final BalanceRepository repository;
  UpdateBalance(this.repository);

  @override
  Future<Either<Failure, void>> call(Balance balance) async {
    return await repository.updateBalance(balance);
  }
}
