import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Budget {
  String name;
  double amount;

  Budget(this.name, this.amount);

  String checkBudgetStatus() {
    return "Budget: $name, Amount: \$${amount.toStringAsFixed(2)}";
  }

  void trackExpense(double expense) {
    amount -= expense;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BudgetPage(),
    );
  }
}

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  List<Budget> Budgets = [
    Budget("Monthly", 3000),
    Budget("Weekly", 700),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: ListView.builder(
        itemCount: Budgets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Budgets[index].checkBudgetStatus()),
            onTap: () {
              // Simulate adding expenses
              setState(() {
                Budgets[index].trackExpense(2500); // Example expense
              });
            },
          );
        },
      ),
    );
  }
}
