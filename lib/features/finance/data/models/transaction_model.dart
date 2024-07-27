import 'package:finance_tracker/features/finance/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required String id,
    required String type,
    required String name,
    required double amount,
    required DateTime date,
    required String time,
  }) : super(id: id ,type: type, name: name, amount: amount, date: date, time: time);

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      amount: json['amount'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'amount': amount,
      'date': date,
      'time': time,
    };
  }
}