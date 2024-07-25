import 'package:finance_tracker/features/notifications_events/domain/models/financial_record.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/financial_repository.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/check_spending_trend.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_category_total.dart';
import 'package:flutter/material.dart';
import '../services/notification_service.dart';


class FinancialProvider with ChangeNotifier {
  final FinancialRepository _repository;
  final NotificationService _notificationService;
  final CheckSpendingTrend _checkSpendingTrend;
  final GetCategoryTotal _getCategoryTotal;

  FinancialProvider({
    required FinancialRepository financialRepository,
    required NotificationService notificationService,
    required CheckSpendingTrend checkSpendingTrend,
    required GetCategoryTotal getCategoryTotal,
  })  : _repository = financialRepository,
        _notificationService = notificationService,
        _checkSpendingTrend = checkSpendingTrend,
        _getCategoryTotal = getCategoryTotal;

  void addFinancialRecord(double amount, DateTime date, bool isExpense, String category) {
    _repository.addRecord(FinancialRecord(amount: amount, date: date, isExpense: isExpense, category: category));
    _checkSpendingTrendAndNotify();
    _checkGoalsAndNotify();
  }

  void _checkSpendingTrendAndNotify() {
    if (_checkSpendingTrend.execute()) {
      _notificationService.showNotification('Expenditure Warning', 'You are spending more than you are earning. Please review your expenses.');
    }
  }

  void _checkGoalsAndNotify() {
    final donationGoal = 500.0; 
    final savingsGoal = 1000.0; 

    final totalDonations = _getCategoryTotal.execute('donation');
    final totalSavings = _getCategoryTotal.execute('savings');

    if (totalDonations >= donationGoal) {
      _notificationService.showNotification('Donation Goal Achieved', 'Congratulations! You have reached your donation goal.');
    }

    if (totalSavings >= savingsGoal) {
      _notificationService.showNotification('Savings Goal Achieved', 'Congratulations! You have reached your savings goal.');
    }
  }
}
