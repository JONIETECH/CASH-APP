import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(int) onTap;

  const TransactionList(
      {super.key, required this.transactions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction.name),
          subtitle: Text('${transaction.type} - ${transaction.amount}'),
          trailing: Text(DateFormat('yyyy-MM-dd').format(transaction.date)),
          onTap: () => onTap(index),
        );
      },
    );
  }
}
