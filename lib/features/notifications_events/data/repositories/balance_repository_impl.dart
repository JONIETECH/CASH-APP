import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/notifications_events/data/datasources/balance_local_data_source.dart';
import 'package:finance_tracker/features/notifications_events/data/models/balance_model.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/balance.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/balance_repository.dart';
import 'package:fpdart/fpdart.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceLocalDataSource localDataSource;

  BalanceRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Balance>> getBalance() async {
    try {
      final balance = await localDataSource.getBalance();
      return Right(balance);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateBalance(Balance balance) async {
    try {
      final balanceModel =
          BalanceModel(amount: balance.amount, minBalance: balance.minBalance);
      await localDataSource.updateBalance(balanceModel);
      return const Right(null);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }
}
