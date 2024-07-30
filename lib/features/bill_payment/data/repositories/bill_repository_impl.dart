// lib/data/repositories/bill_repository_impl.dart
import 'package:finance_tracker/features/bill_payment/domain/entities/bill.dart';
import 'package:finance_tracker/features/bill_payment/domain/repositories/bill_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BillRepositoryImpl implements BillRepository {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  BillRepositoryImpl(this.notificationsPlugin);

  @override
  Future<List<Bill>> getAllBills() async {
    // Retrieve all bills from a data source (e.g., database or API)
    // For now, returning a mock list of bills
    return [
      Bill(
        id: '1',
        title: 'Electricity Bill',
        dueDate: DateTime.now().add(Duration(days: 5)),
        amount: 100.0,
      ),
      Bill(
        id: '2',
        title: 'Water Bill',
        dueDate: DateTime.now().add(Duration(days: 10)),
        amount: 50.0,
      ),
    ];
  }

  @override
  Future<void> addBill(Bill bill) async {
    // Add a new bill to the data source
  }

  @override
  Future<void> updateBill(Bill bill) async {
    // Update an existing bill in the data source
  }

  @override
  Future<void> deleteBill(String billId) async {
    // Delete a bill from the data source
  }

  @override
  Future<void> setBillReminder(Bill bill) async {
    final scheduledNotificationDateTime = bill.dueDate.subtract(const Duration(days: 1));
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      
      'Bill Reminders',
      'Reminds you to pay your bills',
      importance: Importance.max,
      priority: Priority.high,
    );
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await notificationsPlugin.schedule(
      0,
      'Bill Reminder',
      'Don\'t forget to pay your bill: ${bill.title}',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
    );
  }
}
