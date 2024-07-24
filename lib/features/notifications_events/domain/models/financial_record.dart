class FinancialRecord {
  final double amount;
  final DateTime date;
  final bool isExpense; // true if expense, false if income
  final String category; // "donation", "savings", "income", etc.

  FinancialRecord({
    required this.amount,
    required this.date,
    required this.isExpense,
    required this.category,
  });
}
