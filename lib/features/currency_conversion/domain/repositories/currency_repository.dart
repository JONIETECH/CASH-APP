abstract class CurrencyRepository {
  Future<Map<String, double>> getCurrencyRates(String baseCurrency);
}
