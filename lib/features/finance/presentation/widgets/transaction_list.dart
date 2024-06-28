import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, String>> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(transactions[index]['type']!),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transactions[index]['date']!),
              const SizedBox(width: 10),
              Text(transactions[index]['time']!),
            ],
          ),
          trailing: Text(transactions[index]['amount']!),
        );
      },
    );
  }
}
