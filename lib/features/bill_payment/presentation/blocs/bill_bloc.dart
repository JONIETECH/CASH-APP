import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/features/bill_payment/domain/usecases/get_all_bills.dart';
import 'package:finance_tracker/features/bill_payment/domain/usecases/set_bill_reminder.dart';
import 'bill_event.dart';
import 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  final GetAllBills getAllBills;
  final SetBillReminder setBillReminder;

  BillBloc({required this.getAllBills, required this.setBillReminder, required BillLoading initialState}) : super(BillInitial()) {
    on<LoadBills>(_onLoadBills);
    on<AddBillReminder>(_onAddBillReminder);
  }

  Future<void> _onLoadBills(LoadBills event, Emitter<BillState> emit) async {
    emit(BillLoading());
    try {
      final bills = await getAllBills();
      emit(BillLoaded(bills));
    } catch (e) {
      emit(BillError(e.toString()));
    }
  }

  Future<void> _onAddBillReminder(AddBillReminder event, Emitter<BillState> emit) async {
    try {
      await setBillReminder(event.bill);
      add(LoadBills()); 
    } catch (e) {
      emit(BillError(e.toString()));
    }
  }
}
