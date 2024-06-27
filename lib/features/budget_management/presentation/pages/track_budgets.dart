import 'package:flutter/material.dart';

class TrackBudgets extends StatefulWidget {
  static route () => MaterialPageRoute(
    builder: (context) => const TrackBudgets(),
    );

  const TrackBudgets({super.key});

  @override
  State<TrackBudgets> createState() => _TrackBudgetsState();
}

class _TrackBudgetsState extends State<TrackBudgets> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track budgets",style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
      ),
    );
  }
}