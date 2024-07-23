import 'package:finance_tracker/features/charity/presentation/charity_donations_page.dart';
import 'package:flutter/material.dart';

class TrackBudgets extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const TrackBudgets(),
      );

  const TrackBudgets({super.key});

  @override
  State<TrackBudgets> createState() => _TrackBudgetsState();
}

class _TrackBudgetsState extends State<TrackBudgets> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();
  double _savings = 0.0;

  void _calculateSavings() {
    double income = double.tryParse(_incomeController.text) ?? 0.0;
    double expenses = double.tryParse(_expenseController.text) ?? 0.0;
    setState(() {
      _savings = income - expenses;
    });
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _expenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track your cash!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _incomeController,
              decoration: const InputDecoration(
                labelText: 'Input Income',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _expenseController,
              decoration: const InputDecoration(
                labelText: 'Input Expenses',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateSavings,
              child: const Text('Calculate Savings'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Savings: \$${_savings.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CharityDonationsPage()),
                );
              },
              child: const Text('Donations'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: TrackBudgets(),
  ));
}
