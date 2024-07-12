// ignore: unused_import
import 'package:finance_tracker/core/theme/app_pallete.dart';
import 'package:finance_tracker/features/feedback/presentation/pages/reviews.dart';
import 'package:finance_tracker/features/notifications_events/presentation/pages/set_page.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/features/auth/presentation/widgets/logout_confirmation_dialog.dart';
import 'package:finance_tracker/features/budget_management/presentation/pages/track_budgets.dart';

import 'package:finance_tracker/features/settings/presentation/pages/settings_page.dart';
import 'package:finance_tracker/features/ai_automation/presentation/pages/ai_page.dart';
import '../pages/about/main_about.dart';

class AppDrawer extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AppDrawer(),
      );
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(


             color: Colors.blue,
              
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/logos/light.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                const Text(
                  'user@gmail.com',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              //Navigator.push(context, ProfilePage.route());
            },
          ),
          ListTile(
            leading: const Icon(Icons.memory),
            title: const Text('AI'),
            onTap: () {
              Navigator.push(context, Aipage.route());
            },
          ),
          ListTile(
            leading: const Icon(Icons.money_off),
            title: const Text('Future Events'),
            onTap: () {
              Navigator.push(context, FinanceOptionsPage.route());
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Summary'),
            onTap: () {
              // Implement summary
            },
          ),
          ListTile(
            leading: const Icon(Icons.group_rounded),
            title: const Text('Accounts'),
            onTap: () {
              // Implement accounts
            },
          ),
          ListTile(
            leading: const Icon(Icons.text_snippet),
            title: const Text('Report'),
            onTap: () {
              // Implement report
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money_rounded),
            title: const Text('Budget'),
            onTap: () {
              Navigator.push(context, TrackBudgets.route());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(context, SettingsPage.route());
            },
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('About'),
            onTap: () {
              Navigator.push(context, MainAbout.route());
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.push(context, ReviewPage.route());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
