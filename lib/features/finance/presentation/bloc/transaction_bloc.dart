import 'package:bloc/bloc.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/manage_transactions.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;
  final AddTransaction addTransaction;
  final DeleteTransaction deleteTransaction;
  final UpdateTransaction updateTransaction;

  TransactionBloc({
    required this.getTransactions,
    required this.addTransaction,
    required this.deleteTransaction,
    required this.updateTransaction,
  }) : super(TransactionInitial()) {
    on<GetTransactionsEvent>(_onGetTransactions);
    on<AddTransactionEvent>(_onAddTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
  }

  void _onGetTransactions(GetTransactionsEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    final failureOrTransactions = await getTransactions(NoParams());
    emit(failureOrTransactions.fold(
      (failure) => TransactionError(message: 'Failed to fetch transactions'),
      (transactions) => TransactionLoaded(transactions: transactions),
    ));
  }

  void _onAddTransaction(AddTransactionEvent event, Emitter<TransactionState> emit) async {
    final failureOrVoid = await addTransaction(event.transaction);
    failureOrVoid.fold(
      (failure) => emit(TransactionError(message: 'Failed to add transaction')),
      (_) async {
        final failureOrTransactions = await getTransactions(NoParams());
        emit(failureOrTransactions.fold(
          (failure) => TransactionError(message: 'Failed to fetch transactions'),
          (transactions) => TransactionLoaded(transactions: transactions),
        ));
      },
    );
  }

  void _onDeleteTransaction(DeleteTransactionEvent event, Emitter<TransactionState> emit) async {
    final failureOrVoid = await deleteTransaction(event.transaction);
    failureOrVoid.fold(
      (failure) => emit(TransactionError(message: 'Failed to delete transaction')),
      (_) async {
        final failureOrTransactions = await getTransactions(NoParams());
        emit(failureOrTransactions.fold(
          (failure) => TransactionError(message: 'Failed to fetch transactions'),
          (transactions) => TransactionLoaded(transactions: transactions),
        ));
      },
    );
  }

  void _onUpdateTransaction(UpdateTransactionEvent event, Emitter<TransactionState> emit) async {
    final failureOrVoid = await updateTransaction(event.transaction);
    failureOrVoid.fold(
      (failure) => emit(TransactionError(message: 'Failed to update transaction')),
      (_) async {
        final failureOrTransactions = await getTransactions(NoParams());
        emit(failureOrTransactions.fold(
          (failure) => TransactionError(message: 'Failed to fetch transactions'),
          (transactions) => TransactionLoaded(transactions: transactions),
        ));
      },
    );
  }
}
