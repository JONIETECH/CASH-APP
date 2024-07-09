import 'package:flutter/material.dart';

class OptionsMenu extends StatelessWidget {
  final bool isAscending;
  final ValueChanged<bool> onSortOrderChanged;

  const OptionsMenu({
    super.key,
    required this.isAscending,
    required this.onSortOrderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color: theme.cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.download, color: theme.iconTheme.color),
            title: Text('Print', style: theme.textTheme.bodyMedium),
            onTap: () {
              // Implement print functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.help, color: theme.iconTheme.color),
            title: Text('Help', style: theme.textTheme.bodyMedium),
            onTap: () {
              // Implement help functionality
            },
          ),
          const Divider(),
          RadioListTile<bool>(
            title: Text('Date Ascending', style: theme.textTheme.bodyMedium),
            value: true,
            groupValue: isAscending,
            onChanged: (bool? value) {
              if (value != null) {
                onSortOrderChanged(value);
              }
            },
            activeColor: theme.colorScheme.secondary,
          ),
          RadioListTile<bool>(
            title: Text('Date Descending', style: theme.textTheme.bodyMedium),
            value: false,
            groupValue: isAscending,
            onChanged: (bool? value) {
              if (value != null) {
                onSortOrderChanged(value);
              }
            },
            activeColor: theme.colorScheme.inverseSurface,
          ),
        ],
      ),
    );
  }
}
