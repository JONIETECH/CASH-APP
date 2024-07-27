import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';
import 'package:fpdart/fpdart.dart';
import 'package:finance_tracker/core/error/failure.dart';


abstract class TransactionRepository {
  Future<Either<Failure, List<Transaction>>> getTransactions();
  Future<Either<Failure, void>> addTransaction(Transaction transaction);
  Future<Either<Failure, void>> deleteTransaction(Transaction transaction);
  Future<Either<Failure, void>> updateTransaction(Transaction transaction);
}