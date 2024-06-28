import 'package:finance_tracker/features/finance/presentation/widgets/summary.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/app_drawer.dart';
import '../widgets/options_menu.dart';
import '../widgets/transaction_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _filter = 'All'; // Filter option state
  final List<Map<String, String>> transactions = [
    {'type': 'Cash In', 'amount': '10000', 'date': '2024-06-24', 'time': '11:12 am'},
    {'type': 'Cash Out', 'amount': '50000', 'date': '2024-03-23', 'time': '10:18 am'},
    {'type': 'Cash Out', 'amount': '25000', 'date': '2024-02-23', 'time': '10:12 pm'},
  ];

  bool _ascending = false;
  bool _descending = false;

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return OptionsMenu(
          ascending: _ascending,
          descending: _descending,
          onAscendingChanged: (value) {
            setState(() {
              _ascending = value;
            });
          },
          onDescendingChanged: (value) {
            setState(() {
              _descending = value;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalCashIn = transactions
        .where((transaction) => transaction['type'] == 'Cash In')
        .map((transaction) => double.parse(transaction['amount']!))
        .fold(0, (prev, amount) => prev + amount);
    double totalCashOut = transactions
        .where((transaction) => transaction['type'] == 'Cash Out')
        .map((transaction) => double.parse(transaction['amount']!))
        .fold(0, (prev, amount) => prev + amount);
    double balance = totalCashIn - totalCashOut;

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
              // Implement three-dot menu functionality
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: TransactionList(transactions: transactions),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SummaryWidget(
              totalCashIn: totalCashIn,
              totalCashOut: totalCashOut,
              balance: balance,
            ),
          ),
        ],
      ),
    );
  }
}
