import 'package:finance_tracker/features/charity/domain/donation.dart';
import 'package:finance_tracker/features/charity/domain/donation_usecases.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class CharityDonationsViewModel extends ChangeNotifier {
  final TextEditingController donationAmountController = TextEditingController();
  final TextEditingController donationGoalController = TextEditingController();

  double donationGoal = 1000;
  double totalDonations = 0;
  List<Donation> donations = [];

  final DonationUseCases donationUseCases = DonationUseCases();

  void updateDonationGoal() {
    if (donationGoalController.text.isNotEmpty) {
      donationGoal = double.parse(donationGoalController.text);
      donationGoalController.clear();
      notifyListeners();
    }
  }

  void addDonation() {
    if (donationAmountController.text.isNotEmpty) {
      double amount = double.parse(donationAmountController.text);
      totalDonations += amount;
      donations.add(Donation(amount: amount, date: DateTime.now()));
      donationAmountController.clear();
      notifyListeners();
    }
  }

  Future<void> saveDetails() async {
    await donationUseCases.saveDonationDetails(donationGoal, totalDonations, donations);
  }

  PieChartSectionData createSectionData(double value, double total, Color color, String title) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '$title\n${(value / total * 100).toStringAsFixed(1)}%',
      radius: 50,
      titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  @override
  void dispose() {
    donationAmountController.dispose();
    donationGoalController.dispose();
    super.dispose();
  }
}
