import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/finance/domain/entities/finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/add_finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/delete_finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/get_finance_transaction.dart';
import 'package:finance_tracker/features/finance/domain/usecases/update_finance_transaction.dart';
import 'package:fpdart/fpdart.dart';

part 'finance_transaction_event.dart';
part 'finance_transaction_state.dart';

class FinanceTransactionBloc
    extends Bloc<FinanceTransactionEvent, FinanceTransactionState> {
  final GetFinanceTransactions _getFinanceTransactions;
  final AddFinanceTransaction _addFinanceTransaction;
  final UpdateFinanceTransaction _updateFinanceTransaction;
  final DeleteFinanceTransaction _deleteFinanceTransaction;

  FinanceTransactionBloc({
    required GetFinanceTransactions getFinanceTransactions,
    required AddFinanceTransaction addFinanceTransaction,
    required UpdateFinanceTransaction updateFinanceTransaction,
    required DeleteFinanceTransaction deleteFinanceTransaction,
  })  : _getFinanceTransactions = getFinanceTransactions,
        _addFinanceTransaction = addFinanceTransaction,
        _updateFinanceTransaction = updateFinanceTransaction,
        _deleteFinanceTransaction = deleteFinanceTransaction,
        super(FinanceTransactionInitial()) {
    on<LoadFinanceTransactions>(_onLoadFinanceTransactions);
    on<AddNewFinanceTransaction>(_onAddNewFinanceTransaction);
    on<UpdateExistingFinanceTransaction>(_onUpdateExistingFinanceTransaction);
    on<DeleteExistingFinanceTransaction>(_onDeleteExistingFinanceTransaction);
  }
  
  void _onLoadFinanceTransactions(
    LoadFinanceTransactions event,
    Emitter<FinanceTransactionState> emit,
  ) async {
    emit(FinanceTransactionLoading());
    final res = await _getFinanceTransactions(NoParams());

    res.fold(
      (failure) => emit(FinanceTransactionError(failure.message)),
      (transactions) => emit(FinanceTransactionLoaded(transactions)),
    );
  }

  void _onAddNewFinanceTransaction(
    AddNewFinanceTransaction event,
    Emitter<FinanceTransactionState> emit,
  ) async {
    final currentState = state;
    if (currentState is FinanceTransactionLoaded) {
      final List<FinanceTransaction> updatedTransactions = List.from(currentState.transactions)
        ..add(event.transaction);
      emit(FinanceTransactionLoaded(updatedTransactions));
      final Either<Failure, void> res = await _addFinanceTransaction(event.transaction);

      res.fold(
        (failure) {
          emit(FinanceTransactionError(failure.message));
          emit(FinanceTransactionLoaded(currentState.transactions));
        },
        (_) => add(LoadFinanceTransactions()),
      );
    }
  }

  void _onUpdateExistingFinanceTransaction(
    UpdateExistingFinanceTransaction event,
    Emitter<FinanceTransactionState> emit,
  ) async {
    final currentState = state;
    if (currentState is FinanceTransactionLoaded) {
      final List<FinanceTransaction> updatedTransactions = currentState.transactions.map((transaction) {
        return transaction.id == event.transaction.id ? event.transaction : transaction;
      }).toList();
      emit(FinanceTransactionLoaded(updatedTransactions));
      final Either<Failure, void> res = await _updateFinanceTransaction(event.transaction);

      res.fold(
        (failure) {
          emit(FinanceTransactionError(failure.message));
          emit(FinanceTransactionLoaded(currentState.transactions));
        },
        (_) => add(LoadFinanceTransactions()),
      );
    }
  }

  void _onDeleteExistingFinanceTransaction(
    DeleteExistingFinanceTransaction event,
    Emitter<FinanceTransactionState> emit,
  ) async {
    final currentState = state;
    if (currentState is FinanceTransactionLoaded) {
      final List<FinanceTransaction> updatedTransactions = currentState.transactions
          .where((transaction) => transaction.id != event.id)
          .toList();
      emit(FinanceTransactionLoaded(updatedTransactions));
      final Either<Failure, void> res = await _deleteFinanceTransaction(event.id);

      res.fold(
        (failure) {
          emit(FinanceTransactionError(failure.message));
          emit(FinanceTransactionLoaded(currentState.transactions));
        },
        (_) => add(LoadFinanceTransactions()),
      );
    }
  }
}
