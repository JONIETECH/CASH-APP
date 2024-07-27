import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  final double totalCashIn;
  final double totalCashOut;
  final double balance;
  final Color balanceColor;

  const SummaryWidget({
    Key? key,
    required this.totalCashIn,
    required this.totalCashOut,
    required this.balance,
    required this.balanceColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Cash In: \$${totalCashIn.toStringAsFixed(2)}'),
            Text('Total Cash Out: \$${totalCashOut.toStringAsFixed(2)}'),
            Text(
              'Balance: \$${balance.toStringAsFixed(2)}',
              style: TextStyle(color: balanceColor),
            ),
          ],
        ),
      ),
    );
  }
}
