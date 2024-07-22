import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';


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

class CharityDonationsPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const CharityDonationsPage());
  const CharityDonationsPage({super.key});

  @override
  _CharityDonationsPageState createState() => _CharityDonationsPageState();
}

class _CharityDonationsPageState extends State<CharityDonationsPage> with TickerProviderStateMixin {
  final TextEditingController _donationAmountController = TextEditingController();
  final TextEditingController _donationGoalController = TextEditingController();

  double _donationGoal = 1000;
  double _totalDonations = 0;
  List<Map<String, dynamic>> _donations = [];
  Future<void> _saveDetails() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/donations.txt');

  String content = 'Donation Goal: \$$_donationGoal\n';
  content += 'Total Donations: \$$_totalDonations\n';
  content += 'Donations:\n';

  for (var donation in _donations) {
    final date = DateFormat('yyyy-MM-dd').format(donation['date']);
    content += '\$${donation['amount']} on $date\n';
  }

  await file.writeAsString(content);
  await FlutterFileDialog.saveFile(params: SaveFileDialogParams(sourceFilePath: file.path));
}


  void _addDonation(double amount) {
    setState(() {
      _totalDonations += amount;
      _donations.add({'amount': amount, 'date': DateTime.now()});
    });
  }

  void _updateDonationGoal() {
    if (_donationGoalController.text.isNotEmpty) {
      setState(() {
        _donationGoal = double.parse(_donationGoalController.text);
      });
      _donationGoalController.clear();
    }
  }

  @override
  void dispose() {
    _donationAmountController.dispose();
    _donationGoalController.dispose();
    super.dispose();
  }

  PieChartSectionData _createSectionData(double value, double total, Color color, String title) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '$title\n${(value / total * 100).toStringAsFixed(1)}%',
      radius: 50,
      titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    );
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
            TextField(
              controller: _donationGoalController,
              decoration: const InputDecoration(
                labelText: 'Edit donation goal',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _updateDonationGoal,
              child: const Text('Update Goal'),
            ).animate().scale(),
            const SizedBox(height: 10),
            
            Text(
              'Total Donations: \$$_totalDonations',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: [

                SizedBox(
                  height: 150,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        _createSectionData(_totalDonations, _donationGoal, Colors.green, 'Donated'),
                        _createSectionData(_donationGoal - _totalDonations, _donationGoal, Colors.grey, 'Remaining'),
                      ],
                      sectionsSpace: 0,
                      centerSpaceRadius: 30,
                    ),
                  ),
                ),
              ],
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
            ElevatedButton(
            onPressed: _saveDetails,
            child: const Text('Save '),
          ).animate().scale(),
          const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _donations.length,
                itemBuilder: (context, index) {
                  final donation = _donations[index];
                  final date = DateFormat('yyyy-MM-dd').format(donation['date']);
                  return ListTile(
                    title: Text('\$${donation['amount']}'),
                    subtitle: Text('Date: $date'),
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
