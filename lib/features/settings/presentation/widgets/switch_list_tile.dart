// lib/features/settings/presentation/widgets/switch_list_tile.dart

import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitchListTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
