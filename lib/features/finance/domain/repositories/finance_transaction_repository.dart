import 'package:fpdart/fpdart.dart';
import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/finance/domain/entities/finance_transaction.dart';

abstract class FinanceTransactionRepository {
  Future<Either<Failure, List<FinanceTransaction>>> getTransactions();
  Future<Either<Failure, void>> addTransaction(FinanceTransaction transaction);
  Future<Either<Failure, void>> updateTransaction(FinanceTransaction transaction);
  Future<Either<Failure, void>> deleteTransaction(String id);
}
