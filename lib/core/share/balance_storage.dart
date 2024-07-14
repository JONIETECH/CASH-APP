import 'package:shared_preferences/shared_preferences.dart';

class BalanceStorage {
  static Future<void> setBalance(double balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance);
  }

  static Future<double> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('balance') ?? 0.0;
  }
}
