import 'package:finance_tracker/features/notifications_events/presentation/pages/event_form_page.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/features/notifications_events/presentation/pages/balance_page.dart';


class FinanceOptionsPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => FinanceOptionsPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  BalancePage.route(),
                );
              },
              child: const Text('Go to Balance Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  AddEventPage.route(),
                );
              },
              child: const Text('Go to Add Event Page'),
            ),
          ],
        ),
      ),
    );
  }
}
