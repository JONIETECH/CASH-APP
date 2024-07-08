import 'package:finance_tracker/features/finance/domain/entities/finance_transaction.dart';
import 'package:flutter/material.dart';

class FinanceTransactionModel extends FinanceTransaction {
  FinanceTransactionModel(
      {required super.id,
      required super.type,
      required super.name,
      required super.amount,
      required super.date,
      required super.time});

  factory FinanceTransactionModel.fromJson(Map<String, dynamic> json) {
    return FinanceTransactionModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      time: _parseTimeOfDay(json['time']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
      'time': _formatTimeOfDay(time),
    };
  }

  static TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split('')[0]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
