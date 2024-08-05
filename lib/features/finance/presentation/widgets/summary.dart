import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  final double totalCashIn;
  final double totalCashOut;
  final double balance;
  final Color balanceColor;
  final Color totalCashInColor;
  final Color totalCashOutColor;

  const SummaryWidget({
    Key? key,
    required this.totalCashIn,
    required this.totalCashOut,
    required this.balance,
    required this.balanceColor,
    required this.totalCashInColor,
    required this.totalCashOutColor,
  }) : super(key: key); // Correct placement of closing parenthesis

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column( // Added missing child argument to Card
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
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
                    Text(
                      totalCashIn.toStringAsFixed(0),
                      style: TextStyle(color: totalCashInColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Total Cash Out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      totalCashOut.toStringAsFixed(0),
                      style: TextStyle(color: totalCashOutColor),
                    ),
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
          const Divider(
            height: 0,
            color: Colors.grey, // Updated to use a valid color
            thickness: 1.0,
            indent: 5,
            endIndent: 5,
          ),
        ],
      ),
    );
  }
}
