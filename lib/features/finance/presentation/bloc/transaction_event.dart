import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';

abstract class TransactionEvent {}

class GetTransactionsEvent extends TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  AddTransactionEvent({required this.transaction});
}

class DeleteTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  DeleteTransactionEvent({required this.transaction});
}

class UpdateTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  UpdateTransactionEvent({required this.transaction});
}
