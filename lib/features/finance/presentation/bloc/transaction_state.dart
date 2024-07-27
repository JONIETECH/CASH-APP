import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  TransactionLoaded({required this.transactions});
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError({required this.message});
}
