import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BillReminderForm extends StatefulWidget {
  @override
  _BillReminderFormState createState() => _BillReminderFormState();
}

class _BillReminderFormState extends State<BillReminderForm> {
  final _formKey = GlobalKey<FormState>();
  final _billNameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _dueDate;
  TimeOfDay? _reminderTime;
  final SupabaseClient client = GetIt.I<SupabaseClient>();

  @override
  void initState() {
    super.initState();
    OneSignal.shared.setAppId('YOUR_ONESIGNAL_APP_ID');
  }

  Future<void> _addBillReminder() async {
    if (_formKey.currentState!.validate() && _dueDate != null && _reminderTime != null) {
      final reminderDateTime = DateTime(
        _dueDate!.year,
        _dueDate!.month,
        _dueDate!.day,
        _reminderTime!.hour,
        _reminderTime!.minute,
      );

      final bill = {
        'name': _billNameController.text,
        'amount': double.parse(_amountController.text),
        'duedate': reminderDateTime.toIso8601String(),
      };

      try {
        final response = await client.from('bills').insert(bill).select();

        if (response.isNotEmpty) {
          final deviceState = await OneSignal.shared.getDeviceState();
          String? playerId = deviceState?.userId;

          if (playerId != null) {
            await _sendOneSignalNotification(bill, reminderDateTime, playerId);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Your bill reminder has been successfully saved')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to send notification: Player ID not found')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save bill: Unknown error')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save bill: $error')),
        );
      }
    }
  }

  Future<void> _sendOneSignalNotification(Map<String, dynamic> bill, DateTime reminderDateTime, String playerId) async {
    await OneSignal.shared.postNotification(OSCreateNotification(
      playerIds: ['ONESIGNALID'],  
      content: 'Your bill for ${bill['name']} is due on ${DateFormat('yyyy-MM-dd').format(reminderDateTime)}',
      heading: 'Bill Reminder',
      sendAfter: reminderDateTime,  
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Bill Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _billNameController,
                decoration: const InputDecoration(labelText: 'Bill Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bill name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dueDate = pickedDate;
                    });
                  }
                },
                child: Text(
                  _dueDate == null
                      ? 'Pick Due Date'
                      : 'Due Date: ${DateFormat('yyyy-MM-dd').format(_dueDate!)}',
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _reminderTime = pickedTime;
                    });
                  }
                },
                child: Text(
                  _reminderTime == null
                      ? 'Pick Reminder Time'
                      : 'Reminder Time: ${_reminderTime!.format(context)}',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addBillReminder,
                child: const Text('Add Bill Reminder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
