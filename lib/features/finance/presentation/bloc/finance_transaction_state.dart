part of 'finance_transaction_bloc.dart';

sealed class FinanceTransactionState extends Equatable {
  const FinanceTransactionState();

  @override
  List<Object> get props => [];
}

final class FinanceTransactionInitial extends FinanceTransactionState {}

final class FinanceTransactionLoading extends FinanceTransactionState {}

final class FinanceTransactionLoaded extends FinanceTransactionState {
  final List<FinanceTransaction> transactions;

  const FinanceTransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

final class FinanceTransactionError extends FinanceTransactionState {
  final String message;

  const FinanceTransactionError(this.message);

  @override
  List<Object> get props => [message];


}
