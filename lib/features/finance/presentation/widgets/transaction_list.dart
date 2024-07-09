import 'package:flutter/material.dart';
import 'package:finance_tracker/features/finance/domain/entities/finance_transaction.dart';

class TransactionList extends StatelessWidget {
  final List<FinanceTransaction> transactions;
  final Function(FinanceTransaction) onTap;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction.name),
          subtitle: Text('${transaction.type} - ${transaction.amount.toString()}'),
          onTap: () => onTap(transaction),
        );
      },
    );
  }
}
