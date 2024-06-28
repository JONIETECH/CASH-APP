import 'package:flutter/material.dart';

class OptionsMenu extends StatelessWidget {
  final bool ascending;
  final bool descending;
  final ValueChanged<bool> onAscendingChanged;
  final ValueChanged<bool> onDescendingChanged;

  const OptionsMenu({
    super.key,
    required this.ascending,
    required this.descending,
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
            // Implement print functionality
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help'),
          onTap: () {
            // Implement help functionality
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
