import '../models/financial_record.dart';

abstract class FinancialRepository {
  void addRecord(FinancialRecord record);
  double getTotalIncome();
  double getTotalExpenses();
  double getTotalByCategory(String category);
  bool isSpendingExceedingIncome();
}
