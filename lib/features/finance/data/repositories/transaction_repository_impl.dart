import 'package:fpdart/fpdart.dart';
import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/finance/data/datasources/transaction_local_data_source.dart';
import 'package:finance_tracker/features/finance/data/models/transaction_model.dart';
import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';
import 'package:finance_tracker/features/finance/domain/repositories/finance_transaction_repository.dart';
import 'package:uuid/uuid.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() async {
    try {
      final localTransactions = await localDataSource.getLastTransactions();
      return Right(localTransactions);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTransaction(Transaction transaction) async {
    try {
      final transactions = await localDataSource.getLastTransactions();
      transactions.add(transaction as TransactionModel);
      await localDataSource.cacheTransactions(transactions);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(Transaction transaction) async {
    try {
      final transactions = await localDataSource.getLastTransactions();
      transactions.removeWhere((t) => t.name == transaction.name && t.date == transaction.date);
      await localDataSource.cacheTransactions(transactions);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTransaction(Transaction transaction) async {
    try {
      final transactions = await localDataSource.getLastTransactions();
      final index = transactions.indexWhere((t) => t.name == transaction.name && t.date == transaction.date);
      if (index != -1) {
        transactions[index] = transaction as TransactionModel;
        await localDataSource.cacheTransactions(transactions);
      }
      return Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}