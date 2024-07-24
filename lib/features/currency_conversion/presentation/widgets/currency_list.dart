import 'package:flutter/material.dart';
import 'currency_list_item.dart';

class CurrencyList extends StatelessWidget {
  final Map<String, double> rates;
  final String searchTerm;

  const CurrencyList({Key? key, required this.rates, required this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredRates = rates.entries
        .where((entry) => entry.key.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredRates.length,
      itemBuilder: (context, index) {
        final currency = filteredRates[index].key;
        final rate = filteredRates[index].value;
        return CurrencyListItem(currency: currency, rate: rate);
      },
    );
  }
}
