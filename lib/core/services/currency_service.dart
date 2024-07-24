import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String apiKey = dotenv.env['EXCHANGE_RATE_API_KEY']!;
  Future<Map<String, double>> getCurrencyRates(String baseCurrency) async {
    final url =
        'https://v6.exchangerate-api.com/v6/$apiKey/latest/$baseCurrency';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = data['conversion_rates'] as Map<String, dynamic>;
      return rates.map((key, value) => MapEntry(key, value.toDouble()));
    } else {
      throw Exception('Failed to fetch currency rates');
    }
  }
}
