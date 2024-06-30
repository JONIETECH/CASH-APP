// lib/features/settings/presentation/pages/settings_page.dart

import 'package:flutter/material.dart';
import '../widgets/text_form_field.dart';
import '../widgets/switch_list_tile.dart';
import '../widgets/dropdown_list_tile.dart';

class SettingsPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SettingsPage(),
      );
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

  void _saveSettings() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle the save action
    }
  }

  void _logout() {
    // Implement the logic to log out the user
  }

  void _showHelp() {
    // Implement the logic to show help information
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Help'),
          content: Text('How may we help you?'),
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
    // Implement the logic to reset data
    
  }

  void _changePassword() {
    // Implement the logic to change password
    
  }

  void _changePin() {
    // Implement the logic to change PIN
    
  }

  void _setupBiometricLogin() {
    // Implement the logic to set up biometric login
    
  }

  void _deleteAccount() {
    // Implement the logic to delete the account
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: _showHelp,
          ),
        ],
      ),
      body: Container(
        //color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
               
                CustomSwitchListTile(
                  title: 'Enable Notifications',
                  value: _notifications,
                  onChanged: (value) => setState(() => _notifications = value),
                ),
                CustomSwitchListTile(
                  title: 'Enable Dark Mode',
                  value: _darkMode,
                  onChanged: (value) => setState(() => _darkMode = value),
                ),
                CustomDropdownListTile(
                  title: 'Select Theme',
                  value: _theme,
                  items: ['Light', 'Dark'],
                  onChanged: (value) => setState(() => _theme = value!),
                ),
                CustomDropdownListTile(
                  title: 'Select Language',
                  value: _language,
                  items: [
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
                  onChanged: (value) => setState(() => _locationAccess = value),
                ),
                CustomDropdownListTile(
                  title: 'Currency Format',
                  value: _currencyFormat,
                  items: ['USH', 'KSH', 'TSH', 'USD', 'EUR'],
                  onChanged: (value) =>
                      setState(() => _currencyFormat = value!),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.backup),
                  title: Text('Backup Data'),
                  trailing: ElevatedButton(
                    onPressed: _backupData,
                    child: Text('Backup'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.restore),
                  title: Text('Restore Data'),
                  trailing: ElevatedButton(
                    onPressed: _restoreData,
                    child: Text('Restore'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.reset_tv),
                  title: Text('Reset Data'),
                  trailing: ElevatedButton(
                    onPressed: _resetData,
                    child: Text('Reset'),
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
                ListTile(
                  leading: const Icon(Icons.fingerprint),
                  title: const Text('Setup Biometric Login'),
                  trailing: ElevatedButton(
                    onPressed: _setupBiometricLogin,
                    child: const Text('Setup'),
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
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    '© 2024 Finance Tracker. All rights reserved.',
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
