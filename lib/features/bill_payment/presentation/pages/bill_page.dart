// lib/features/bill_payment/presentation/pages/bill_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/features/bill_payment/presentation/blocs/bill_bloc.dart';
import 'package:finance_tracker/features/bill_payment/presentation/blocs/bill_event.dart';
import 'package:finance_tracker/features/bill_payment/presentation/blocs/bill_state.dart';
import 'package:get_it/get_it.dart';

class BillPage extends StatelessWidget {
  const BillPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<void>(builder: (_) => const BillPage());
  }

  @override
  Widget build(BuildContext context) {
    final billBloc = GetIt.I<BillBloc>(); // Accessing BillBloc from GetIt

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Payment Reminder'),
      ),
      body: BlocBuilder<BillBloc, BillState>(
        bloc: billBloc,
        builder: (context, state) {
          if (state is BillLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BillLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.bills.length,
                    itemBuilder: (context, index) {
                      final bill = state.bills[index];
                      return ListTile(
                        title: Text(bill.title),
                        subtitle: Text('Due: ${bill.dueDate.toLocal()}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {
                            billBloc.add(AddBillReminder(bill));
                          },
                        ),
                      );
                    },
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // Add new bill logic
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            );
          } else if (state is BillError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
