import 'package:finance_tracker/features/notifications_events/domain/entities/balance.dart';

class BalanceModel extends Balance {
  BalanceModel({
    required double amount,
    required double minBalance,
  }) : super(
          amount: amount,
          minBalance: minBalance,
        );
  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      amount: json['amount'],
      minBalance: json['minBalance'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'minBalance': minBalance,
    };
  }
}
