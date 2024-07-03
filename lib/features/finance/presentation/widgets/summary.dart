import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  final double totalCashIn;
  final double totalCashOut;
  final double balance;
  final Color balanceColor;

  const SummaryWidget({
    super.key,
    required this.totalCashIn,
    required this.totalCashOut,
    required this.balance,
    required this.balanceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    'Total Cash In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(totalCashIn.toStringAsFixed(0)),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Total Cash Out',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(totalCashOut.toStringAsFixed(0)),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Balance',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    balance.toStringAsFixed(0),
                    style: TextStyle(
                      color: balanceColor, // Apply the balanceColor here
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
