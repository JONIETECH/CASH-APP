import 'package:finance_tracker/features/bill_payment/domain/entities/bill.dart';

abstract class BillRepository {
  Future<List<Bill>> getAllBills();
  Future<void> addBill(Bill bill);
  Future<void> updateBill(Bill bill);
  Future<void> deleteBill(String billId);
  Future<void> setBillReminder(Bill bill);
}
