import 'package:flutter/material.dart';

class AddTransactionDialog extends StatefulWidget {
  final String type;
  final Function(Map<String, String>) onSave;
  const AddTransactionDialog(
      {super.key, required this.onSave, required this.type});



  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now(); // Initialize with current date
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
