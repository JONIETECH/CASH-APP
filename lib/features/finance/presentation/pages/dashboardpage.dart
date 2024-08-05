import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/transaction_bloc.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/transaction_event.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../widgets/app_drawer.dart';
import '../widgets/options_menu.dart';
import '../widgets/transaction_list.dart';
import '../widgets/summary.dart'; // Make sure this is correct

class DashboardPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const DashboardPage());
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _filter = 'All';
  String _searchQuery = '';
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionBloc>(context).add(GetTransactionsEvent());
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
            // Sort logic will be added here
          },
        );
      },
    );
  }

  void _showAddTransactionDialog(BuildContext context, String type, [Transaction? transaction]) {
    TextEditingController amountController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay? selectedTime = TimeOfDay.now();

    if (transaction != null) {
      amountController.text = transaction.amount.toString();
      nameController.text = transaction.name;
      selectedDate = transaction.date;
      selectedTime = TimeOfDay.fromDateTime(transaction.date);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor.withOpacity(0.9),
          title: Text(transaction == null ? 'Add $type' : 'Update $type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    contentPadding: EdgeInsets.only(left: 15.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    contentPadding: EdgeInsets.only(left: 15.0),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                ),
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
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                ),
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
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.inverseSurface,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.inverseSurface,
              ),
              onPressed: () {
                final newTransaction = Transaction(
                  id: transaction?.id ?? UniqueKey().toString(),
                  type: type,
                  name: nameController.text,
                  amount: double.parse(amountController.text),
                  date: DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime!.hour,
                    selectedTime!.minute,
                  ),
                  time: selectedTime!.format(context), // Pass the time here
                );
                if (transaction == null) {
                  BlocProvider.of<TransactionBloc>(context).add(AddTransactionEvent(transaction: newTransaction));
                } else {
                  BlocProvider.of<TransactionBloc>(context).add(UpdateTransactionEvent(transaction: newTransaction));
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

  void _showTransactionOptionsDialog(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: const Text('Transaction Options'),
          content: const Text('Would you like to update or delete this transaction?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.inverseSurface,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showAddTransactionDialog(context, transaction.type, transaction);
              },
              child: const Text('Update'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                side: BorderSide(color: Theme.of(context).colorScheme.inverseSurface),
              ),
              onPressed: () {
                BlocProvider.of<TransactionBloc>(context).add(DeleteTransactionEvent(transaction: transaction));
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  List<Transaction> _filteredTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    return transactions.where((transaction) {
      bool matchesFilter = true;

      if (_filter == 'Daily') {
        matchesFilter = transaction.date.difference(now).inDays == 0;
      } else if (_filter == 'Weekly') {
        matchesFilter = transaction.date.isAfter(now.subtract(const Duration(days: 7)));
      } else if (_filter == 'Monthly') {
        matchesFilter = transaction.date.isAfter(now.subtract(const Duration(days: 30)));
      } else if (_filter == 'Yearly') {
        matchesFilter = transaction.date.isAfter(now.subtract(const Duration(days: 365)));
      }
      if (_searchQuery.isNotEmpty) {
        matchesFilter = matchesFilter &&
            transaction.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }
      return matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Tracker'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _filter = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return {'All', 'Daily', 'Weekly', 'Monthly', 'Yearly'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showOptionsMenu(context);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SummaryWidget(
                    totalCashIn: totalCashIn,
                    totalCashOut: totalCashOut,
                    balance: balance,
                    balanceColor: balanceColor,
                    totalCashInColor: Colors.green, // Add this
                    totalCashOutColor: Colors.red, // Add this
                  ),
                ),
                Expanded(
                  child: TransactionList(
                    transactions: transactions,
                    onTransactionTap: (transaction) {
                      _showTransactionOptionsDialog(context, transaction);
                    }, onTap: (int ) {  },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Failed to load transactions'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 150,
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.arrow_circle_up, color: Colors.green),
                      title: const Text('Cash In'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _showAddTransactionDialog(context, 'Cash In');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.arrow_circle_down, color: Colors.red),
                      title: const Text('Cash Out'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _showAddTransactionDialog(context, 'Cash Out');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
