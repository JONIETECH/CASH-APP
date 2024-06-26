import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  bool _notifications = false;
  bool _darkMode = false;
  String _theme = 'Light';
  String _language = 'English';
  bool _locationAccess = false;
  String _profilePictureUrl = '';
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
    print('Data backed up');
  }

  void _restoreData() {
    // Implement the logic to restore data
    print('Data restored');
  }

  void _resetData() {
    // Implement the logic to reset data
    print('Data reset');
  }

  void _changePassword() {
    // Implement the logic to change password
    print('Password changed');
  }

  void _changePin() {
    // Implement the logic to change PIN
    print('PIN changed');
  }

  void _setupBiometricLogin() {
    // Implement the logic to set up biometric login
    print('Biometric login set up');
  }

  void _deleteAccount() {
    // Implement the logic to delete the account
    print('Account deleted');
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
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildProfilePictureSection(),
                SizedBox(height: 20),
                _buildTextFormField(
                  label: 'Username',
                  onSaved: (value) => _username = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                _buildTextFormField(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _email = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                _buildTextFormField(
                  label: 'Password',
                  obscureText: true,
                  onSaved: (value) => _password = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _buildSwitchListTile(
                  title: 'Enable Notifications',
                  value: _notifications,
                  onChanged: (value) => setState(() => _notifications = value),
                ),
                _buildSwitchListTile(
                  title: 'Enable Dark Mode',
                  value: _darkMode,
                  onChanged: (value) => setState(() => _darkMode = value),
                ),
                _buildDropdownListTile(
                  title: 'Select Theme',
                  value: _theme,
                  items: ['Light', 'Dark'],
                  onChanged: (value) => setState(() => _theme = value!),
                ),
                _buildDropdownListTile(
                  title: 'Select Language',
                  value: _language,
                  items: ['English', 'Spanish', 'French', 'Arabic', 'Portuguese'],
                  onChanged: (value) => setState(() => _language = value!),
                ),
                _buildSwitchListTile(
                  title: 'Enable Location Access',
                  value: _locationAccess,
                  onChanged: (value) => setState(() => _locationAccess = value),
                ),
                _buildDropdownListTile(
                  title: 'Currency Format',
                  value: _currencyFormat,
                  items: ['USH', 'KSH', 'TSH', 'USD', 'EUR'],
                  onChanged: (value) => setState(() => _currencyFormat = value!),
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

  Widget _buildProfilePictureSection() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _profilePictureUrl.isEmpty
              ? AssetImage('assets/default_profile_picture.png')
              : NetworkImage(_profilePictureUrl) as ImageProvider,
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile Picture',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            TextButton(
              onPressed: () {
                // Implement the logic to upload and get the profile picture URL
              },
              child: const Text(
                'Change Profile Picture',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    required String label,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  

  Widget _buildDropdownListTile({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
