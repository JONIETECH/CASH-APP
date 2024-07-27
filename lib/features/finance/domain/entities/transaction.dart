import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String type;
  final String name;
  final double amount;
  final DateTime date;
  final String time;

  const Transaction({
    required this.id,
    required this.type,
    required this.name,
    required this.amount,
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [id,type, name, amount, date, time];
}
