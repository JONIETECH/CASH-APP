import 'package:finance_tracker/core/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/app_drawer.dart';
import '../widgets/options_menu.dart';
import '../widgets/transaction_list.dart';
import '../widgets/summary.dart';
import 'package:intl/intl.dart';


class DashboardPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const DashboardPage());
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _filter = 'All';
  String _searchQuery = '';
  List<Map<String, String>> transactions = [];
  bool _isAscending = true;
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _saveTransactions() async {
    await _sharedPreferencesService.saveTransactions(transactions);
  }

  Future<void> _loadTransactions() async {
    transactions = await _sharedPreferencesService.loadTransactions();
    setState(() {});
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
            _sortTransactions();
          },
        );
      },
    );
  }

  void _showAddTransactionDialog(String type, [int? index]) {
    TextEditingController amountController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    DateTime selectedDate = DateTime.now(); // Initialize with current date
    TimeOfDay? selectedTime;

    if (index != null) {
      amountController.text = transactions[index]['amount']!;
      nameController.text = transactions[index]['name']!;
      selectedDate = DateTime.parse(transactions[index]['date']!);
      selectedTime = TimeOfDay(
        hour: int.parse(transactions[index]['time']!.split(':')[0]),
        minute:
            int.parse(transactions[index]['time']!.split(':')[1].split(' ')[0]),
      );
    } else {
      selectedTime = TimeOfDay.now();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor.withOpacity(0.9),
          title: Text(index == null ? 'Add $type' : 'Update $type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    20.0, 0.0, 20.0, 8.0), // Add space between the input fields
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    contentPadding: EdgeInsets.only(left: 15.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    20.0, 8.0, 20.0, 0.0), // Add space between the input fields
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    contentPadding: EdgeInsets.only(
                        left: 15.0), // Control the height of the input field
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    backgroundColor:
                        Theme.of(context).colorScheme.inverseSurface),
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
                    backgroundColor:
                        Theme.of(context).colorScheme.inverseSurface),
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
                  foregroundColor:
                      Theme.of(context).colorScheme.inverseSurface),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor:
                      Theme.of(context).colorScheme.inverseSurface),
              onPressed: () {
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
                Navigator.of(context).pop();
              },
              child: Text(index == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  void _showTransactionOptionsDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: const Text('Transaction Options'),
          content: const Text(
              'Would you like to update or delete this transaction?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor:
                      Theme.of(context).colorScheme.inverseSurface),
              onPressed: () {
                Navigator.of(context).pop();
                _showAddTransactionDialog(transactions[index]['type']!, index);
              },
              child: const Text(
                'Update',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.inverseSurface)),
              onPressed: () {
                setState(() {
                  transactions.removeAt(index);
                });
                _saveTransactions();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, String>> _filteredTransactions() {
    DateTime now = DateTime.now();
    return transactions.where((transaction) {
      DateTime date = DateTime.parse(transaction['date']!);
      bool matchesFilter = true;

      if (_filter == 'Daily') {
        matchesFilter = date.difference(now).inDays == 0;
      } else if (_filter == 'Weekly') {
        matchesFilter = date.isAfter(now.subtract(const Duration(days: 7)));
      } else if (_filter == 'Monthly') {
        matchesFilter = date.isAfter(now.subtract(const Duration(days: 30)));
      } else if (_filter == 'Yearly') {
        matchesFilter = date.isAfter(now.subtract(const Duration(days: 365)));
      }
      if (_searchQuery.isNotEmpty) {
        matchesFilter = matchesFilter &&
            transaction['name']!
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }
      return matchesFilter;
    }).toList();
  }

  void _sortTransactions() {
    setState(() {
      transactions.sort((a, b) {
        DateTime dateA = DateTime.parse(a['date']!);
        DateTime dateB = DateTime.parse(b['date']!);
        return _isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
      });
    });
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
    Color balanceColor = balance >= 0
        ? Theme.of(context).colorScheme.inverseSurface
        : Colors.red;

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
              return {'All', 'Daily', 'Weekly', 'Monthly', 'Yearly'}
                  .map((String choice) {
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
      body: Column(
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
              balanceColor:
                  balanceColor, // Pass the determined color to SummaryWidget
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
                ),
                child: const Text('Cash In'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => _showAddTransactionDialog('Cash Out'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 40),
                  side: const BorderSide(width: 0),
                  backgroundColor: Colors.red, // Set button color to red
                ),
                child: const Text('Cash Out'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}