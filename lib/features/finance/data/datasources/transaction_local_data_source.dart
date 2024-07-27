import 'dart:convert';

import 'package:finance_tracker/features/finance/data/models/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getLastTransactions();
  Future<void> cacheTransactions(List<TransactionModel> transactions);
  Future<void> clearTransactions();
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final SharedPreferences sharedPreferences;

  TransactionLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TransactionModel>> getLastTransactions() async {
    try {
      final jsonString = sharedPreferences.getString('transactions');
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList
            .map((json) => TransactionModel.fromJson(json))
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
  Future<void> cacheTransactions(List<TransactionModel> transactions) async {
    try {
      final List<Map<String, dynamic>> jsonList =
          transactions.map((transaction) => transaction.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString('transactions', jsonString);
    } catch (e) {
      // Handle the error, e.g., log it or rethrow
      print('Error saving transactions: $e');
    }
  }

  @override
  Future<void> clearTransactions() async {
    try {
      await sharedPreferences.remove('transactions');
      print('Transactions cleared successfully.');
    } catch (e) {
      // Handle the error, e.g., log it or rethrow
      print('Error clearing transactions: $e');
    }
  }
}
