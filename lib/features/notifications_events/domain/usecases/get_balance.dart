import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/balance.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/balance_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBalance implements UseCase<Balance, NoParams> {
  final BalanceRepository repository;
  GetBalance(this.repository);

  @override
  Future<Either<Failure, Balance>> call(NoParams params) async {
    return await repository.getBalance();

  }
}
