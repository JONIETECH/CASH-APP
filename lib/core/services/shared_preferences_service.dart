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
}
