import 'dart:convert';

import 'package:finance_tracker/features/finance/data/models/finance_transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FinanceLocalDataSource {
  Future<List<FinanceTransactionModel>> getTransactions();
  Future<void> saveTransactions(List<FinanceTransactionModel> transactions);
}

class FinanceLocalDataSourceImpl implements FinanceLocalDataSource {
  final SharedPreferences sharedPreferences;
  FinanceLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<FinanceTransactionModel>> getTransactions() async {
    final jsonString = sharedPreferences.getString('finance_transactions');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((json) => FinanceTransactionModel.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> saveTransactions(List<FinanceTransactionModel> transactions) async {
    final List<Map<String, dynamic>> jsonList =
        transactions.map((transaction) => transaction.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString('finance_transactions', jsonString);
  }
}
