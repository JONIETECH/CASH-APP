part of 'finance_transaction_bloc.dart';

sealed class FinanceTransactionEvent extends Equatable {
  const FinanceTransactionEvent();

  @override
  List<Object> get props => [];
}

final class LoadFinanceTransactions extends FinanceTransactionEvent {}

final class AddNewFinanceTransaction extends FinanceTransactionEvent {
  final FinanceTransaction transaction;
  const AddNewFinanceTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}

final class UpdateExistingFinanceTransaction extends FinanceTransactionEvent {
  final FinanceTransaction transaction;
  const UpdateExistingFinanceTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}

final class DeleteExistingFinanceTransaction extends FinanceTransactionEvent {
  final String id;
  const DeleteExistingFinanceTransaction(this.id);

  @override
  List<Object> get props => [id];

}
