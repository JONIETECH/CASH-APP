

part of 'balance_bloc.dart';

abstract class BalanceEvent extends Equatable {
  const BalanceEvent();

  @override
  List<Object> get props => [];
}

class LoadBalance extends BalanceEvent {}

class ModifyBalance extends BalanceEvent {
  final Balance balance;

  const ModifyBalance({required this.balance});

  @override
  List<Object> get props => [balance];
}

class CheckBalanceEvent extends BalanceEvent {
  final double threshold;

  const CheckBalanceEvent({required this.threshold});

  @override
  List<Object> get props => [threshold];
}
