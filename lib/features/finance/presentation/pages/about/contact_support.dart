import 'package:flutter/material.dart';

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Support'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(''' If you have questions or comments about this app, feel free to contact us at:

[Finance Tracker]
[P.O.Box 1234,]
[Kampala, Uganda]
[financetracker@gmail.com]
[+256 234 709 145]'''

        ),
          
        ),
      );
    
  }
}