
import 'package:finance_tracker/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';

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
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const Text(
                  'user@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
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
              // Implement profile functionality
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
              // Implement budget
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
              // Implement about
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Implement logout functionality
            },
          ),
        ],
      ),
    );
  }
}
