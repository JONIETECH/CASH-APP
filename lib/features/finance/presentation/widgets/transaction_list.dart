import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(int) onTap;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onTap, required Null Function(dynamic transaction) onTransactionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reversedTransactions = transactions.reversed.toList();

    return ListView.builder(
      itemCount: reversedTransactions.length,
      itemBuilder: (context, index) {
        final transaction = reversedTransactions[index];
        final isCashOut = transaction.type == 'Cash Out';
        final amountColor = isCashOut ? Colors.red : Colors.green;

        return Column(
          children: [
            ListTile(
              title: Text(transaction.name),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat('yyyy-MM-dd').format(transaction.date)),
                  const SizedBox(width: 10),
                  Text(transaction.time), // Ensure `time` is a String in your Transaction model
                ],
              ),
              trailing: Text(
                '\$${transaction.amount.toStringAsFixed(2)}', // Format amount
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
