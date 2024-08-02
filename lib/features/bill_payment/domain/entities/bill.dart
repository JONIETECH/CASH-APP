class Bill {
  final String id;
  final String title;
  final DateTime dueDate;
  final double amount;
  final bool isPaid;

  Bill({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.amount,
    this.isPaid = false,
  });
}