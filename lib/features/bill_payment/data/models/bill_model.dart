import 'package:finance_tracker/features/bill_payment/domain/entities/bill.dart';

class BillModel extends Bill {
  BillModel({
    required super.id,
    required super.title,
    required super.dueDate,
    required super.amount,
    super.isPaid,
  });

  factory BillModel.fromEntity(Bill bill) {
    return BillModel(
      id: bill.id,
      title: bill.title,
      dueDate: bill.dueDate,
      amount: bill.amount,
      isPaid: bill.isPaid,
    );
  }

  Bill toEntity() {
    return Bill(
      id: id,
      title: title,
      dueDate: dueDate,
      amount: amount,
      isPaid: isPaid,
    );
  }
}

