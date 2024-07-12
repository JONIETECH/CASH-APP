import 'package:finance_tracker/features/notifications_events/data/models/balance_model.dart';

abstract class BalanceLocalDataSource {
  Future<BalanceModel> getBalance();
  Future<void> updateBalance(BalanceModel balance);
}
