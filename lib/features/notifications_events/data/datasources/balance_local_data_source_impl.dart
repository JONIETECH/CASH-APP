import 'dart:convert';

import 'package:finance_tracker/features/notifications_events/data/datasources/balance_local_data_source.dart';
import 'package:finance_tracker/features/notifications_events/data/models/balance_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceLocalDataSourceImpl implements BalanceLocalDataSource {
  final SharedPreferences sharedPreferences;

  BalanceLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<BalanceModel> getBalance() async {
    final jsonString = sharedPreferences.getString('BALANCE');
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return BalanceModel.fromJson(jsonMap);
    } else {
      return BalanceModel(amount: 0.0, minBalance: 0.0);
    }
  }

  @override
  Future<void> updateBalance(BalanceModel balance) async {
    final jsonString = json.encode(balance.toJson());
    await sharedPreferences.setString('BALANCE', jsonString);
  }
}
