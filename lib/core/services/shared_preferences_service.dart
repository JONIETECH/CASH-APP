import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesService {
  Future<void> saveTransactions(List<Map<String, String>> transactions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('transactions', jsonEncode(transactions));
  }

  Future<List<Map<String, String>>> loadTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? transactionsString = prefs.getString('transactions');
    if (transactionsString != null) {
      List<dynamic> jsonData = jsonDecode(transactionsString);
      // Convert each dynamic map to a Map<String, String>
      return jsonData.map((item) => Map<String, String>.from(item)).toList();
    }
    return [];
  }
  Future<void> saveCurrencyRates(Map<String, double> rates) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currencyRates', jsonEncode(rates));
  }

  Future<Map<String, double>> loadCurrencyRates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ratesString = prefs.getString('currencyRates');

    if (ratesString != null) {
      Map<String, dynamic> jsonData = jsonDecode(ratesString);
      return jsonData.map((key, value) => MapEntry(key, value.toDouble()));
    }

    return {};
  }
}
