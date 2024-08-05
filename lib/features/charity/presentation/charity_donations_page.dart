import 'package:finance_tracker/features/charity/presentation/charity_donations_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CharityDonationsPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const CharityDonationsPage());
  const CharityDonationsPage({super.key});
  
  // Function to launch the GoFundMe URL
  Future<void> _launchGoFundMeURL() async {
    const url = 'https://www.gofundme.com'; // Replace with your GoFundMe link
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to launch another URL (if needed)
  Future<void> _launchAnotherURL() async {
    const url = 'https://www.globalgiving.org'; // Replace with another link
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to launch another URL (if needed)
  Future<void> _launchOtherURL() async {
    const url = 'https://fundrazr.com/'; // Replace with another link
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CharityDonationsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Donations'),
        ),
        body: SingleChildScrollView(  // Wrap with SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<CharityDonationsViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure full width for elements
                  children: [
                    // Existing elements like goal and total donations
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
                      height: 200,  // Fixed height for PieChart
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
                          onPressed: () async {
                            await viewModel.saveDonations(context);
                          },
                          child: const Text('Save'),
                        ).animate().scale(),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Fixed height for ListView to prevent overflow
                    SizedBox(
                      height: 200,  // Set an appropriate height for the list
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
                    
                     const SizedBox(height: 20),
                  const Text(
                    'Together, we can change lives and bring hope to those in need. You can make a donation today!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
                  ),
                  const SizedBox(height: 20),

                  
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: _launchGoFundMeURL,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset('assets/images/gofundme.jpg', height: 80), // Replace with your image path
                                    const SizedBox(height: 8),
                                    const Text('Support Us on GoFundMe', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: _launchAnotherURL,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset('assets/images/gg.jpg', height: 80), // Replace with your image path
                                    const SizedBox(height: 8),
                                    const Text('You can also support us on GlobalGiving', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: _launchOtherURL,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset('assets/images/fr.jpg', height: 80), // Replace with your image path
                                    const SizedBox(height: 8),
                                    const Text('Join us on Fundrazr', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
