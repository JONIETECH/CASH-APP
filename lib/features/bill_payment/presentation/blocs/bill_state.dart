import 'package:equatable/equatable.dart';
import 'package:finance_tracker/features/bill_payment/domain/entities/bill.dart';

abstract class BillState extends Equatable {
  const BillState();

  @override
  List<Object> get props => [];
}

class BillInitial extends BillState {}

class BillLoading extends BillState {}

class BillLoaded extends BillState {
  final List<Bill> bills;

  const BillLoaded(this.bills);

  @override
  List<Object> get props => [bills];
}

class BillError extends BillState {
  final String message;

  const BillError(this.message);

  @override
  List<Object> get props => [message];
}
