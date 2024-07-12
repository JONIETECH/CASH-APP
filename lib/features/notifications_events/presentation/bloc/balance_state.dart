

part of 'balance_bloc.dart';

abstract class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object> get props => [];
}

class BalanceInitial extends BalanceState {}

class BalanceLoading extends BalanceState {}

class BalanceLoaded extends BalanceState {
  final Balance balance;

  const BalanceLoaded({required this.balance});

  @override
  List<Object> get props => [balance];
}

class BalanceUpdated extends BalanceState {}

class BalanceError extends BalanceState {
  final String message;

  const BalanceError({required this.message});

  @override
  List<Object> get props => [message];
}
