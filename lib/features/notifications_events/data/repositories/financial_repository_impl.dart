import 'package:finance_tracker/features/notifications_events/domain/models/financial_record.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/financial_repository.dart';


class FinancialRepositoryImpl implements FinancialRepository {
  final List<FinancialRecord> _records = [];

  FinancialRepositoryImpl(Object object);

  @override
  void addRecord(FinancialRecord record) {
    _records.add(record);
  }

  @override
  double getTotalIncome() {
    return _records
        .where((record) => !record.isExpense)
        .fold(0.0, (total, record) => total + record.amount);
  }

  @override
  double getTotalExpenses() {
    return _records
        .where((record) => record.isExpense)
        .fold(0.0, (total, record) => total + record.amount);
  }

  @override
  double getTotalByCategory(String category) {
    return _records
        .where((record) => record.category == category)
        .fold(0.0, (total, record) => total + record.amount);
  }

  @override
  bool isSpendingExceedingIncome() {
    return getTotalExpenses() > getTotalIncome();
  }
}
