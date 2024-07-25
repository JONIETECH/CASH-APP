import 'package:finance_tracker/core/services/currency_service.dart';
import 'package:finance_tracker/features/currency_conversion/domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyService currencyService;

  CurrencyRepositoryImpl(this.currencyService);

  @override
  Future<Map<String, double>> getCurrencyRates(String baseCurrency) async {
    return await currencyService.getCurrencyRates(baseCurrency);
  }
}
