import 'package:flutter/material.dart';

class FinanceTransaction {
  final String id;
  final String type;
  final String name;
  final double amount;
  final DateTime date;
  final TimeOfDay time;

  FinanceTransaction({
    required this.id,
    required this.type,
    required this.name,
    required this.amount,
    required this.date,
    required this.time,
  });
}
