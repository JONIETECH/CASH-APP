import 'package:finance_tracker/features/charity/presentation/charity_donations_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class CharityDonationsPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const CharityDonationsPage());
  const CharityDonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CharityDonationsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Donations'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CharityDonationsViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  Text(
                    'Donation Goal: \$${viewModel.donationGoal}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: viewModel.donationGoalController,
                    decoration: const InputDecoration(
                      labelText: 'Edit donation goal',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: viewModel.updateDonationGoal,
                    child: const Text('Update Goal'),
                  ).animate().scale(),
                  const SizedBox(height: 10),
                  Text(
                    'Total Donations: \$${viewModel.totalDonations}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          viewModel.createSectionData(viewModel.totalDonations, viewModel.donationGoal, Colors.green, 'Donated'),
                          viewModel.createSectionData(viewModel.donationGoal - viewModel.totalDonations, viewModel.donationGoal, Colors.grey, 'Remaining'),
                        ],
                        sectionsSpace: 0,
                        centerSpaceRadius: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: viewModel.donationAmountController,
                    decoration: const InputDecoration(
                      labelText: 'Enter donation amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: viewModel.addDonation,
                        child: const Text('Donate'),
                      ).animate().scale(),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: viewModel.saveDetails,
                        child: const Text('Save'),
                      ).animate().scale(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.donations.length,
                      itemBuilder: (context, index) {
                        final donation = viewModel.donations[index];
                        final date = DateFormat('yyyy-MM-dd').format(donation.date);
                        return ListTile(
                          title: Text('\$${donation.amount}'),
                          subtitle: Text('Date: $date'),
                        ).animate().fadeIn(duration: Duration(milliseconds: 300 * (index + 1)));
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
