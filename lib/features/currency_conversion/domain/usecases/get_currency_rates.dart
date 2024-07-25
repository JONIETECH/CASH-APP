import 'package:finance_tracker/features/currency_conversion/domain/repositories/currency_repository.dart';

class GetCurrencyRates {
  final CurrencyRepository repository;
  GetCurrencyRates(this.repository);

  Future<Map<String, double>> execute(String baseCurrency) async {
    return await repository.getCurrencyRates(baseCurrency);
  }
}
