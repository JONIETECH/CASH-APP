import '../repositories/financial_repository.dart';

class CheckSpendingTrend {
  final FinancialRepository repository;

  CheckSpendingTrend(this.repository);

  bool execute() {
    return repository.isSpendingExceedingIncome();
  }
}
