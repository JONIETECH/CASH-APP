import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class CharityDonationsViewModel extends ChangeNotifier {
  final TextEditingController donationGoalController = TextEditingController();
  final TextEditingController donationAmountController = TextEditingController();

  double donationGoal = 0;
  double totalDonations = 0;
  List<Donation> donations = [];

  CharityDonationsViewModel() {
    _loadDonations();
  }

  void updateDonationGoal() {
    donationGoal = double.tryParse(donationGoalController.text) ?? 0;
    notifyListeners();
  }

  void addDonation() {
    final donationAmount = double.tryParse(donationAmountController.text) ?? 0;
    if (donationAmount > 0) {
      donations.add(Donation(donationAmount, DateTime.now()));
      totalDonations += donationAmount;
      donationAmountController.clear();
      notifyListeners();
    }
  }

  Future<void> saveDonations(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final donationList = donations.map((donation) => donation.toJson()).toList();
    await prefs.setString('donations', jsonEncode(donationList));
    await prefs.setDouble('donationGoal', donationGoal);
    await prefs.setDouble('totalDonations', totalDonations);


    
    ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: Text('Successfully saved!')),
  );
  }

  Future<void> _loadDonations() async {
    final prefs = await SharedPreferences.getInstance();
    final donationListString = prefs.getString('donations');
    if (donationListString != null) {
      final List<dynamic> donationListJson = jsonDecode(donationListString);
      donations = donationListJson.map((json) => Donation.fromJson(json)).toList();
      donationGoal = prefs.getDouble('donationGoal') ?? 0;
      totalDonations = prefs.getDouble('totalDonations') ?? 0;
      notifyListeners();
    }
  }

  PieChartSectionData createSectionData(double value, double total, Color color, String title) {
    final double percentage = (value / total) * 100;
    return PieChartSectionData(
      color: color,
      value: value,
      title: '${percentage.toStringAsFixed(1)}%',
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class Donation {
  final double amount;
  final DateTime date;

  Donation(this.amount, this.date);

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      json['amount'],
      DateTime.parse(json['date']),
    );
  }
}
