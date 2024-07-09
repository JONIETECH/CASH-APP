import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/finance/domain/entities/finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/repositories/finance_transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetFinanceTransactions {
  final FinanceTransactionRepository repository;

  GetFinanceTransactions(this.repository);

  Future<Either<Failure, List<FinanceTransaction>>> call(NoParams params) async {
    return await repository.getTransactions();
  }
}
