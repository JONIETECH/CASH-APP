import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/balance.dart';
import 'package:fpdart/fpdart.dart';

abstract class BalanceRepository {
  Future<Either<Failure, Balance>> getBalance();
  Future<Either<Failure,void>> updateBalance(Balance balance);
}
