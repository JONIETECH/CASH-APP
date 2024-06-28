import 'package:flutter/material.dart';
class DeveloperInformationPage extends StatelessWidget {
  const DeveloperInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Information'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text( '''Developer: Finance Tracker Team
                        Email: developer@financetrscker.com'''
          
        ),
      ),
    );
  }
}
