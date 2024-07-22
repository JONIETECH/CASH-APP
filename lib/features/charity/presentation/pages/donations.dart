import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const CharityPage());
}

class CharityPage extends StatelessWidget {
  const CharityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Charity Donations',
      home: CharityDonationsPage(),
    );
  }
}

class CharityDonationsPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const CharityDonationsPage());
  const CharityDonationsPage({super.key});

  @override
  _CharityDonationsPageState createState() => _CharityDonationsPageState();
}

class _CharityDonationsPageState extends State<CharityDonationsPage> with TickerProviderStateMixin {
  final TextEditingController _donationAmountController = TextEditingController();

  double _donationGoal = 1000;
  double _totalDonations = 0;
  List<double> _donations = [];

  void _addDonation(double amount) {
    setState(() {
      _totalDonations += amount;
      _donations.add(amount);
    });
  }

  @override
  void dispose() {
    _donationAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charity Donations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Donation Goal: \$$_donationGoal',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _totalDonations / _donationGoal,
              minHeight: 10,
            ).animate().fadeIn().slideX(duration: const Duration(seconds: 1)),
            const SizedBox(height: 10),
            Text(
              'Total Donations: \$$_totalDonations',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _donationAmountController,
              decoration: const InputDecoration(
                labelText: 'Enter donation amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_donationAmountController.text.isNotEmpty) {
                  double amount = double.parse(_donationAmountController.text);
                  _addDonation(amount);
                  _donationAmountController.clear();
                }
              },
              child: const Text('Donate'),
            ).animate().scale(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _donations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('\$${_donations[index]}'),
                  ).animate().fadeIn(duration: Duration(milliseconds: 300 * (index + 1)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
