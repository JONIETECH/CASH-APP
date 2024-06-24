import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const FinanceTrackerApp());
}

class FinanceTrackerApp extends StatelessWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DashboardPage(),
    );
  }
}

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
  bool _darktheme = false;

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Print'),
              onTap: () {
                // Implement settings functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                // Implement help functionality
              },
            ),
            CheckboxListTile(
              title: const Text('Dark Theme'),
              value: _darktheme,
              onChanged: (bool? value) {
                setState(() {
                  _darktheme = value!;
                });
              },
            ),
            const Divider(),
            CheckboxListTile(
              title: const Text('Date Ascending'),
              value: _ascending,
              onChanged: (bool? value) {
                setState(() {
                  _ascending = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Date Descending'),
              value: _descending,
              onChanged: (bool? value) {
                setState(() {
                  _descending = value!;
                });
              },
            ),
          ],
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/logos/light.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    'user@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                // Implement profile functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Summary'),
              onTap: () {
                // Implement summary
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_rounded),
              title: const Text('Accounts'),
              onTap: () {
                // Implement accounts
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_snippet),
              title: const Text('Report'),
              onTap: () {
                // Implement report
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money_rounded),
              title: const Text('Budget'),
              onTap: () {
                // Implement budget
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Implement settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('About'),
              onTap: () {
                // Implement about
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Implement logout functionality
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(transactions[index]['type']!),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transactions[index]['date']!),
                      const SizedBox(width: 10),
                      Text(transactions[index]['time']!),
                    ],
                  ),
                  trailing: Text(transactions[index]['amount']!),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Implement add income functionality
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.green[700]),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      child: const Text('Cash In'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Implement add expense functionality
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.red[700]),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      child: const Text('Cash Out'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Total Cash In',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(totalCashIn.toStringAsFixed(0)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Total Cash Out',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(totalCashOut.toStringAsFixed(0)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Balance',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(balance.toStringAsFixed(0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
