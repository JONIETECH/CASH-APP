import 'package:finance_tracker/features/finance/domain/entities/finance_transaction.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/finance_transaction_bloc.dart';
import 'package:finance_tracker/features/finance/presentation/widgets/app_drawer.dart';
import 'package:finance_tracker/features/finance/presentation/widgets/options_menu.dart';
import 'package:finance_tracker/features/finance/presentation/widgets/summary.dart';
import 'package:finance_tracker/features/finance/presentation/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _filter = 'All';
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    context.read<FinanceTransactionBloc>().add(LoadFinanceTransactions());
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return OptionsMenu(
          isAscending: _isAscending,
          onSortOrderChanged: (value) {
            setState(() {
              _isAscending = value;
            });
          },
        );
      },
    );
  }

  void _showAddTransactionDialog(String type, [FinanceTransaction? transaction]) {
    TextEditingController amountController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay? selectedTime = TimeOfDay.now();

    if (transaction != null) {
      amountController.text = transaction.amount.toString();
      nameController.text = transaction.name;
      selectedDate = transaction.date;
      selectedTime = transaction.time;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(transaction == null ? 'Add $type' : 'Update $type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              TextButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
              ),
              TextButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime!,
                  );
                  if (picked != null && picked != selectedTime) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
                child: Text(selectedTime!.format(context)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FinanceTransaction newTransaction = FinanceTransaction(
                  id: transaction?.id ?? DateTime.now().toString(),
                  type: type,
                  name: nameController.text,
                  amount: double.parse(amountController.text),
                  date: selectedDate,
                  time: selectedTime!,
                );

                if (transaction == null) {
                  context.read<FinanceTransactionBloc>().add(AddNewFinanceTransaction(newTransaction));
                } else {
                  context.read<FinanceTransactionBloc>().add(UpdateExistingFinanceTransaction(newTransaction));
                }

                Navigator.of(context).pop();
              },
              child: Text(transaction == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  void _showTransactionOptionsDialog(FinanceTransaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Transaction Options'),
          content: const Text('Would you like to update or delete this transaction?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showAddTransactionDialog(transaction.type, transaction);
              },
              child: const Text('Update'),
            ),
            TextButton(
              onPressed: () {
                context.read<FinanceTransactionBloc>().add(DeleteExistingFinanceTransaction(transaction.id));
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  List<FinanceTransaction> _filteredTransactions(List<FinanceTransaction> transactions) {
    DateTime now = DateTime.now();
    return transactions.where((transaction) {
      DateTime date = transaction.date;
      if (_filter == 'Daily') {
        return date.difference(now).inDays == 0;
      } else if (_filter == 'Weekly') {
        return date.isAfter(now.subtract(const Duration(days: 7)));
      } else if (_filter == 'Monthly') {
        return date.isAfter(now.subtract(const Duration(days: 30)));
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _filter = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return {'All', 'Daily', 'Weekly', 'Monthly'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            onPressed: () {
              _showOptionsMenu(context);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<FinanceTransactionBloc, FinanceTransactionState>(
        builder: (context, state) {
          if (state is FinanceTransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FinanceTransactionLoaded) {
            final transactions = _filteredTransactions(state.transactions);

            double totalCashIn = transactions
                .where((transaction) => transaction.type == 'Cash In')
                .map((transaction) => transaction.amount)
                .fold(0, (prev, amount) => prev + amount);
            double totalCashOut = transactions
                .where((transaction) => transaction.type == 'Cash Out')
                .map((transaction) => transaction.amount)
                .fold(0, (prev, amount) => prev + amount);
            double balance = totalCashIn - totalCashOut;

            Color balanceColor = balance >= 0
                ? Theme.of(context).colorScheme.inverseSurface
                : Colors.red;

            return Column(
              children: [
                Expanded(
                  child: TransactionList(
                    transactions: transactions,
                    onTap: (transaction) {
                      _showTransactionOptionsDialog(transaction);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SummaryWidget(
                    totalCashIn: totalCashIn,
                    totalCashOut: totalCashOut,
                    balance: balance,
                    balanceColor: balanceColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showAddTransactionDialog('Cash In'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Cash In'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _showAddTransactionDialog('Cash Out'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Cash Out'),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is FinanceTransactionError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No Transactions Found'));
          }
        },
      ),
    );
  }
}
