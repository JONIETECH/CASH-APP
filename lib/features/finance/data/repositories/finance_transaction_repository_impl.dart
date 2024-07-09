import 'package:fpdart/fpdart.dart';
import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/finance/data/datasources/finance_local_data_source.dart';
import 'package:finance_tracker/features/finance/data/models/finance_transaction_model.dart';
import 'package:finance_tracker/features/finance/domain/entities/finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/repositories/finance_transaction_repository.dart';
import 'package:uuid/uuid.dart';

class FinanceTransactionRepositoryImpl implements FinanceTransactionRepository {
  final FinanceLocalDataSource financeLocalDataSource;

  FinanceTransactionRepositoryImpl({required this.financeLocalDataSource});

  @override
  Future<Either<Failure, void>> addTransaction(FinanceTransaction transaction) async {
    try {
      final transactions = await financeLocalDataSource.getTransactions();
      final newTransaction = FinanceTransactionModel(
        id: const Uuid().v4(),
        type: transaction.type,
        name: transaction.name,
        amount: transaction.amount,
        date: transaction.date,
        time: transaction.time,
      );
      transactions.add(newTransaction);
      await financeLocalDataSource.saveTransactions(transactions);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String id) async {
    try {
      final transactions = await financeLocalDataSource.getTransactions();
      transactions.removeWhere((transaction) => transaction.id == id);
      await financeLocalDataSource.saveTransactions(transactions);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FinanceTransaction>>> getTransactions() async {
    try {
      final transactions = await financeLocalDataSource.getTransactions();
      return Right(transactions);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTransaction(FinanceTransaction transaction) async {
    try {
      final transactions = await financeLocalDataSource.getTransactions();
      final index = transactions.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        transactions[index] = FinanceTransactionModel(
          id: transaction.id,
          type: transaction.type,
          name: transaction.name,
          amount: transaction.amount,
          date: transaction.date,
          time: transaction.time,
        );
        await financeLocalDataSource.saveTransactions(transactions);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
