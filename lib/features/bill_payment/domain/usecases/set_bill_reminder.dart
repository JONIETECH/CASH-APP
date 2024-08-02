import 'package:finance_tracker/features/bill_payment/domain/entities/bill.dart';
import 'package:finance_tracker/features/bill_payment/domain/repositories/bill_repository.dart';

class SetBillReminder {
  final BillRepository repository;

  SetBillReminder(this.repository);

  Future<void> call(Bill bill) async {
    await repository.setBillReminder(bill);
  }
}
