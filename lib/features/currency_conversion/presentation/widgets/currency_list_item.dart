import 'package:flutter/material.dart';

class CurrencyListItem extends StatelessWidget {
  final String currency;
  final double rate;

  const CurrencyListItem({Key? key, required this.currency, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$currency: $rate'),
    );
  }
}
