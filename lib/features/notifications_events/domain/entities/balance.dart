import 'package:equatable/equatable.dart';

class Balance extends Equatable {
  final double amount;
  final double minBalance;

  const Balance({
    required this.amount,
    required this.minBalance,
  });
  @override
  List<Object?> get props => [amount, minBalance];
}
