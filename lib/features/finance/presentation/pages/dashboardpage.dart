<<<<<<< HEAD
import 'package:finance_tracker/core/services/shared_preferences_service.dart';
=======
import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/transaction_bloc.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/transaction_event.dart';
import 'package:finance_tracker/features/finance/presentation/bloc/transaction_state.dart';
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../widgets/app_drawer.dart';
import '../widgets/options_menu.dart';
import '../widgets/transaction_list.dart';
import '../widgets/summary.dart';
<<<<<<< HEAD
import 'package:intl/intl.dart';
=======
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0

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
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _loadTransactions();
  }

  Future<void> _saveTransactions() async {
    await _sharedPreferencesService.saveTransactions(transactions);
  }

  Future<void> _loadTransactions() async {
    transactions = await _sharedPreferencesService.loadTransactions();
    setState(() {});
=======
    BlocProvider.of<TransactionBloc>(context).add(GetTransactionsEvent());
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0
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
<<<<<<< HEAD
                double amount = double.tryParse(amountController.text) ?? 0;
                if (type == 'Cash Out' && (amount > totalCashIn || (totalCashOut + amount) > totalCashIn)) {
                  // Show error dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Insufficient funds for this transaction.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                setState(() {
                  if (index == null) {
                    transactions.add({
                      'type': type,
                      'name': nameController.text,
                      'amount': amountController.text,
                      'date': DateFormat('yyyy-MM-dd').format(selectedDate),
                      'time': selectedTime!.format(context),
                    });
                  } else {
                    transactions[index] = {
                      'type': type,
                      'name': nameController.text,
                      'amount': amountController.text,
                      'date': DateFormat('yyyy-MM-dd').format(selectedDate),
                      'time': selectedTime!.format(context),
                    };
                  }
                  _sortTransactions();
                });
                _saveTransactions();
=======
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
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0
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

<<<<<<< HEAD
  void _sortTransactions() {
    setState(() {
      transactions.sort((a, b) {
        DateTime dateA = DateTime.parse(a['date']!);
        DateTime dateB = DateTime.parse(b['date']!);
        return _isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
      });
    });
  }

  double get totalCashIn {
    return transactions
        .where((transaction) => transaction['type'] == 'Cash In')
        .fold(0, (sum, transaction) => sum + double.parse(transaction['amount']!));
  }

  double get totalCashOut {
    return transactions
        .where((transaction) => transaction['type'] == 'Cash Out')
        .fold(0, (sum, transaction) => sum + double.parse(transaction['amount']!));
  }

  @override
  Widget build(BuildContext context) {
    double totalCashIn = _filteredTransactions()
        .where((transaction) => transaction['type'] == 'Cash In')
        .map((transaction) => double.parse(transaction['amount']!))
        .fold(0, (prev, amount) => prev + amount);
    double totalCashOut = _filteredTransactions()
        .where((transaction) => transaction['type'] == 'Cash Out')
        .map((transaction) => double.parse(transaction['amount']!))
        .fold(0, (prev, amount) => prev + amount);
    double balance = totalCashIn - totalCashOut;

    // Determine text color for balance based on its value
    Color balanceColor = balance >= 0 ? Colors.green : Colors.red;
    Color totalCashOutColor = Colors.red;
    Color totalCashInColor = Colors.green;

=======
  @override
  Widget build(BuildContext context) {
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0
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
                  padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 6.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search transactions...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            //_searchQuery = '';
                          });
                        },
                      ),
                    ),
                  ),
                ),
<<<<<<< HEAD
              ),
            ),
          ),
          Expanded(
            child: TransactionList(
              transactions: _filteredTransactions(),
              onTap: (index) {
                _showTransactionOptionsDialog(index);
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
              totalCashInColor: totalCashInColor,
              totalCashOutColor: totalCashOutColor,
              // Pass the determined color to SummaryWidget
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _showAddTransactionDialog('Cash In'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 40),
                  side: const BorderSide(width: 0),
                  backgroundColor: Colors.green, // Set button color to green
=======
                Expanded(
                  child: TransactionList(
                    transactions: transactions,
                    onTap: (index) {
                      _showTransactionOptionsDialog(context, transactions[index]);
                    },
                  ),
>>>>>>> fbee0da67ae653b074ed14e485041eee1498bcc0
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
                      onPressed: () => _showAddTransactionDialog(context, 'Cash In'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        side: const BorderSide(width: 0),
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Cash In'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _showAddTransactionDialog(context, 'Cash Out'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        side: const BorderSide(width: 0),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Cash Out'),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is TransactionError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Failed to load transactions'));
          }
        },
      ),
    );
  }
}
