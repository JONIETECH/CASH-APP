import 'dart:convert';

import 'package:finance_tracker/features/finance/data/models/finance_transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FinanceLocalDataSource {
  Future<List<FinanceTransactionModel>> getTransactions();
  Future<void> saveTransactions(List<FinanceTransactionModel> transactions);
  Future<void> clearTransactions();
}

class FinanceLocalDataSourceImpl implements FinanceLocalDataSource {
  final SharedPreferences sharedPreferences;
  FinanceLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<FinanceTransactionModel>> getTransactions() async {
    try {
      final jsonString = sharedPreferences.getString('finance_transactions');
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList
            .map((json) => FinanceTransactionModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // Handle the error, e.g., log it or return an empty list
      print('Error retrieving transactions: $e');
      return [];
    }
  }

  @override
  Future<void> saveTransactions(List<FinanceTransactionModel> transactions) async {
    try {
      final List<Map<String, dynamic>> jsonList =
          transactions.map((transaction) => transaction.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString('finance_transactions', jsonString);
    } catch (e) {
      // Handle the error, e.g., log it or rethrow
      print('Error saving transactions: $e');
    }
  }

  @override
  Future<void> clearTransactions() async {
    try {
      await sharedPreferences.remove('finance_transactions');
      print('Finance transactions cleared successfully.');
    } catch (e) {
      // Handle the error, e.g., log it or rethrow
      print('Error clearing transactions: $e');
    }
  }
}
