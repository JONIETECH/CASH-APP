import 'package:finance_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:finance_tracker/features/auth/presentation/widgets/logout_confirmation_dialog.dart';
import 'package:finance_tracker/features/security/presentation/bloc/biometric_bloc.dart';
import 'package:finance_tracker/features/settings/presentation/bloc/reset_bloc.dart';
import 'package:finance_tracker/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/switch_list_tile.dart';
import '../widgets/dropdown_list_tile.dart';

class SettingsPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      );

  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  bool _notifications = false;
  bool _darkMode = false;
  String _theme = 'Light';
  String _language = 'English';
  bool _locationAccess = false;
  String _currencyFormat = 'USD';
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    // Load the initial biometric status
    BlocProvider.of<BiometricBloc>(context).add(LoadBiometricStatus());
    // Load the initial theme status
    BlocProvider.of<ThemeBloc>(context).add(LoadThemeStatus());
  }

  void _saveSettings() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle the save action
    }
  }

  void _logout() {
    showLogoutConfirmationDialog(context);
    // Implement the logic to log out the user
  }

  void _showHelp() {
    // Implement the logic to show help information
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Help'),
          content: const Text('How may we help you?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _backupData() {
    // Implement the logic to backup data
  }

  void _restoreData() {
    // Implement the logic to restore data
  }

  void _resetData() {
    // Dispatch the reset event
    BlocProvider.of<ResetBloc>(context).add(ResetAppData());
  }

  void _changePassword() {
    // Implement the logic to change password
  }

  void _changePin() {
    // Implement the logic to change PIN
  }

  void _deleteAccount() {
    // Implement the logic to delete the account
  }

  void _toggleBiometricLogin(bool value) {
    _showConfirmationDialog(value);
  }

  void _showConfirmationDialog(bool value) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text(
              'Are you sure you want to ${value ? "enable" : "disable"} biometric login?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _biometricEnabled = value;
                });
                BlocProvider.of<BiometricBloc>(context)
                    .add(UpdateBiometricStatus(status: value));
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _toggleTheme(bool value) {
    BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: _showHelp,
          ),
        ],
      ),
      body: BlocListener<BiometricBloc, BiometricState>(
        listener: (context, state) {
          if (state is BiometricLoaded) {
            setState(() {
              _biometricEnabled = state.status;
            });
          }
        },
        child: BlocListener<ThemeBloc, ThemeState>(
          listener: (context, state) {
            if (state is ThemeInitial) {
              setState(() {
                _darkMode = state.themeMode == ThemeMode.dark;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomSwitchListTile(
                    title: 'Enable Notifications',
                    value: _notifications,
                    onChanged: (value) =>
                        setState(() => _notifications = value),
                  ),
                  CustomSwitchListTile(
                    title: 'Change theme',
                    value: _darkMode,
                    onChanged: (value) => _toggleTheme(value),
                  ),
                  CustomDropdownListTile(
                    title: 'Select Language',
                    value: _language,
                    items: const [
                      'English',
                      'Spanish',
                      'French',
                      'Arabic',
                      'Portuguese'
                    ],
                    onChanged: (value) => setState(() => _language = value!),
                  ),
                  CustomSwitchListTile(
                    title: 'Enable Location Access',
                    value: _locationAccess,
                    onChanged: (value) =>
                        setState(() => _locationAccess = value),
                  ),
                  CustomDropdownListTile(
                    title: 'Currency',
                    value: _currencyFormat,
                    items: const ['USH', 'KSH', 'TSH', 'USD', 'EUR'],
                    onChanged: (value) =>
                        setState(() => _currencyFormat = value!),
                  ),
                  CustomSwitchListTile(
                    title: 'Enable Biometric Login',
                    value: _biometricEnabled,
                    onChanged: (value) => _toggleBiometricLogin(value),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.backup),
                    title: const Text('Backup Data'),
                    trailing: ElevatedButton(
                      onPressed: _backupData,
                      child: const Text('Backup'),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.restore),
                    title: const Text('Restore Data'),
                    trailing: ElevatedButton(
                      onPressed: _restoreData,
                      child: const Text('Restore'),
                    ),
                  ),
                  BlocListener<ResetBloc, ResetState>(
                    listener: (context, state) {
                      if (state is ResetAppLoading) {
                        // Show loading indicator
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20),
                                  Text("Resetting data..."),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (state is ResetAppSuccess) {
                        // Hide the loading indicator
                        Navigator.pop(context);
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data reset successfully"),
                          ),
                        );
                        //Navigate to login screen
                        Navigator.pushReplacement(context, LoginPage.route());
                      } else if (state is ResetAppError) {
                        // Hide the loading indicator
                        Navigator.pop(context);
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Failed to reset data: ${state.message}"),
                          ),
                        );
                      }
                    },
                    child: ListTile(
                      leading: const Icon(Icons.reset_tv),
                      title: const Text('Reset Data'),
                      trailing: ElevatedButton(
                        onPressed: _resetData,
                        child: const Text('Reset'),
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.password),
                    title: const Text('Change Password'),
                    trailing: ElevatedButton(
                      onPressed: _changePassword,
                      child: const Text('Change'),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.pin),
                    title: const Text('Change PIN'),
                    trailing: ElevatedButton(
                      onPressed: _changePin,
                      child: const Text('Change'),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.view_day),
                    title: const Text('Set first day of week'),
                    trailing: ElevatedButton(
                      onPressed: _changePin,
                      child: const Text('Change'),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.view_day),
                    title: const Text('Set first day of month'),
                    trailing: ElevatedButton(
                      onPressed: _changePin,
                      child: const Text('Change'),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.monetization_on),
                    title: const Text('Currency format'),
                    trailing: ElevatedButton(
                      onPressed: _changePin,
                      child: const Text('Change'),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.delete_forever),
                    title: const Text('Delete Account'),
                    trailing: ElevatedButton(
                      onPressed: _deleteAccount,
                      child: const Text('Delete'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveSettings,
                    child: const Text(
                      'Save Settings',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      '© 2024 Finance Tracker. All rights reserved.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
