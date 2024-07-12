import 'package:flutter/material.dart';

class AccountManagementPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AccountManagementPage(),
      );

  const AccountManagementPage({Key? key}) : super(key: key);

  @override
  _AccountManagementPageState createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  List<String> accounts = []; // List to hold account names
  int? selectedAccountIndex; // Index of the currently activated account

  // Function to show add account dialog
  Future<void> _showAddAccountDialog(BuildContext context) async {
    String newAccountName = ''; // Variable to hold the new account name

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Account'),
          content: TextField(
            onChanged: (value) {
              newAccountName = value; // Update new account name as user types
            },
            decoration: const InputDecoration(hintText: 'Enter account name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // Validate if newAccountName is not empty
                if (newAccountName.isNotEmpty) {
                  setState(() {
                    accounts.add(newAccountName); // Add new account name to list
                    selectedAccountIndex = accounts.length - 1; // Activate the new account
                  });
                }
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show delete confirmation dialog
  Future<void> _showDeleteConfirmationDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete this account?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.red, side: BorderSide(color: Theme.of(context).colorScheme.inverseSurface)),
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  accounts.removeAt(index); // Remove account from list
                  if (selectedAccountIndex == index) {
                    selectedAccountIndex = null; // Clear selection if deleted account was active
                  }
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Accounts'),
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Text(accounts[index]),
                if (selectedAccountIndex == index)
                  const Icon(Icons.check, color: Colors.green), // Show check icon if selected
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context, index); // Show confirmation dialog before deleting
              },
            ),
            onTap: () {
              setState(() {
                selectedAccountIndex = index; // Activate tapped account
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAccountDialog(context); // Show dialog for adding new account
        },
        tooltip: 'Add Account',
        child: const Icon(Icons.add),
      ),
    );
  }
}
