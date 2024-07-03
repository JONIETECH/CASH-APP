import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, String>> transactions;
  final Function(int) onTap;

  const TransactionList({super.key, required this.transactions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isCashOut = transaction['type'] == 'Cash Out';
        final amountColor = isCashOut ? Colors.red : Theme.of(context).textTheme.bodyMedium!.color;

        return ListTile(
          title: Text(transaction['name']!),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transaction['date']!),
              const SizedBox(width: 10),
              Text(transaction['time']!),
            ],
          ),
          trailing: Text(
            transaction['amount']!,
            style: TextStyle(color: amountColor),
          ),
          onTap: () => onTap(index), // Call the onTap callback with the index
        );
      },
    );
  }
}
