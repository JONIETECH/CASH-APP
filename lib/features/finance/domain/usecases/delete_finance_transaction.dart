import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/finance/domain/repositories/finance_transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteFinanceTransaction {
  final FinanceTransactionRepository repository;
  DeleteFinanceTransaction(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    try {
      await repository.deleteTransaction(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
