// lib/bill_reminder_form.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase/supabase.dart';

class BillReminderForm extends StatefulWidget {
  @override
  _BillReminderFormState createState() => _BillReminderFormState();
}

class _BillReminderFormState extends State<BillReminderForm> {
  final _formKey = GlobalKey<FormState>();
  final _billNameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _dueDate;
  final SupabaseClient client = SupabaseClient('your-supabase-url', 'your-supabase-key');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    final android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(settings);
  }

  Future<void> _addBillReminder() async {
    if (_formKey.currentState!.validate() && _dueDate != null) {
      final bill = {
        'name': _billNameController.text,
        'amount': double.parse(_amountController.text),
        'due_date': _dueDate!.toIso8601String(),
      };

      try {
        
        final response = await client
            .from('bills')
            .insert(bill)
            .select();

        if (response.isNotEmpty) {
          
          await _scheduleNotification(bill);
          Navigator.pop(context);
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

  Future<void> _scheduleNotification(Map<String, dynamic> bill) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      
      'Bill Reminders',
      'Channel for bill reminders',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
      0,
      'Bill Reminder',
      'Your bill for ${bill['name']} is due on ${DateFormat('yyyy-MM-dd').format(DateTime.parse(bill['due_date']))}',
      DateTime.parse(bill['due_date']),
      platformChannelSpecifics,
    );
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
