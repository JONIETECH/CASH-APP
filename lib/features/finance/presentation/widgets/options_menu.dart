import 'package:flutter/material.dart';

class OptionsMenu extends StatelessWidget {
  final bool darktheme;
  final bool ascending;
  final bool descending;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<bool> onAscendingChanged;
  final ValueChanged<bool> onDescendingChanged;

  const OptionsMenu({
    super.key,
    required this.darktheme,
    required this.ascending,
    required this.descending,
    required this.onThemeChanged,
    required this.onAscendingChanged,
    required this.onDescendingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.download),
          title: const Text('Print'),
          onTap: () {
            // Implement settings functionality
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help'),
          onTap: () {
            // Implement help functionality
          },
        ),
        CheckboxListTile(
          title: const Text('Dark Theme'),
          value: darktheme,
          onChanged: (bool? value) {
            onThemeChanged(value!);
          },
        ),
        const Divider(),
        CheckboxListTile(
          title: const Text('Date Ascending'),
          value: ascending,
          onChanged: (bool? value) {
            onAscendingChanged(value!);
          },
        ),
        CheckboxListTile(
          title: const Text('Date Descending'),
          value: descending,
          onChanged: (bool? value) {
            onDescendingChanged(value!);
          },
        ),
      ],
    );
  }
}
