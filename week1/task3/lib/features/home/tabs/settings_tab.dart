import 'package:flutter/material.dart';
import '../../../widgets/custom_widgets.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: NoDataPlaceholder(message: 'comming soon', ico: Icons.settings_outlined));
  }
}
