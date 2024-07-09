import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/finance/domain/entities/finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/repositories/finance_transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddFinanceTransaction {
  final FinanceTransactionRepository repository;
  AddFinanceTransaction(this.repository);

  Future<Either<Failure, void>> call(FinanceTransaction transaction) async {
    try {
      await repository.addTransaction(transaction);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
