import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, String>> transactions;
  final Function(int) onTap;

  // ignore: use_super_parameters
  const TransactionList({Key? key, required this.transactions, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isCashOut = transaction['type'] == 'Cash Out';
        final amountColor = isCashOut ? Colors.red : Theme.of(context).textTheme.bodyMedium!.color;

        return Column(
          children: [
            ListTile(
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
            ),
            const Divider(
              height: 0,
              thickness: 0.8,
              indent: 5,
              endIndent: 5,
            ),
          ],
        );
      },
    );
  }
}
