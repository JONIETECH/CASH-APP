import 'package:finance_tracker/features/charity/presentation/charity_donations_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const CharityPage());
}

class CharityPage extends StatelessWidget {
  const CharityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Donations',
      home: CharityDonationsPage(),
    );
  }
}
