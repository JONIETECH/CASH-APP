import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_balance.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/update_balance.dart';
import 'package:finance_tracker/features/notifications_events/presentation/bloc/balance_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class BalancePage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => BalancePage(),
      );

  final getBalance = GetIt.instance<GetBalance>();
  final updateBalance = GetIt.instance<UpdateBalance>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance Page'),
      ),
      body: BlocProvider(
        create: (context) => BalanceBloc(getBalance: getBalance, updateBalance: updateBalance)
          ..add(LoadBalance()),
        child: BlocBuilder<BalanceBloc, BalanceState>(
          builder: (context, state) {
            if (state is BalanceLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BalanceLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current Balance: \$${state.balance.amount.toStringAsFixed(2)}'),
                  ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setDouble('balance', state.balance.amount);
                    },
                    child: Text('Save Balance'),
                  ),
                ],
              );
            } else if (state is BalanceError) {
              return Center(child: Text('Failed to load balance: ${state.message}'));
            } else {
              return Center(child: Text('No balance data.'));
            }
          },
        ),
      ),
    );
  }
}
