import 'package:finance_tracker/features/currency_conversion/presentation/pages/currency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_tracker/core/common/entities/user.dart';
import 'package:finance_tracker/features/account_management/account_management.dart';
import 'package:finance_tracker/features/auth/presentation/pages/profile_page.dart';
import 'package:finance_tracker/features/feedback/presentation/pages/reviews.dart';
import 'package:finance_tracker/features/finance_blog/presentation/pages/blog_page.dart';
import 'package:finance_tracker/features/notifications_events/presentation/pages/set_page.dart';
import 'package:finance_tracker/features/budget_management/presentation/pages/track_budgets.dart';
import 'package:finance_tracker/features/settings/presentation/pages/settings_page.dart';
import 'package:finance_tracker/features/ai_automation/presentation/pages/ai_page.dart';
import '../pages/about/main_about.dart';
import 'package:finance_tracker/features/auth/presentation/widgets/logout_confirmation_dialog.dart';

class AppDrawer extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AppDrawer(),
      );
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            final User user = state.user;
            return ListView(
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
                          isDarkMode
                              ? 'assets/images/logos/dark.jpg'
                              : 'assets/images/logos/light.jpg',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.push(context, ProfilePage.route());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Finance Blogs'),
                  onTap: () {
                    Navigator.push(context, BlogPage.route());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.memory),
                  title: const Text('Finance AI'),
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
                  leading: const Icon(Icons.attach_money_rounded),
                  title: const Text('Check Currency'),
                  onTap: () {
                    Navigator.push(context, CurrencyPage.route());
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
                    Navigator.push(context, AccountManagementPage.route());
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
            );
          } else if (state is AuthFailure) {
            return Center(
              child: Text('Failed to load profile: ${state.message}'),
            );
          } else {
            return const Center(child: Text('No profile data available'));
          }
        },
      ),
    );
  }
}
