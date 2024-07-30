import 'package:finance_tracker/features/bill_payment/domain/entities/bill.dart';
import 'package:finance_tracker/features/bill_payment/domain/repositories/bill_repository.dart';

class GetAllBills {
  final BillRepository repository;

  GetAllBills(this.repository);

  Future<List<Bill>> call() async {
    return await repository.getAllBills();
  }
}

