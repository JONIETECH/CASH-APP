import 'package:equatable/equatable.dart';
import 'package:finance_tracker/features/bill_payment/domain/entities/bill.dart';

abstract class BillEvent extends Equatable {
  const BillEvent();

  @override
  List<Object> get props => [];
}

class LoadBills extends BillEvent {}

class AddBillReminder extends BillEvent {
  final Bill bill;

  const AddBillReminder(this.bill);

  @override
  List<Object> get props => [bill];
}
