import 'package:flutter/material.dart';
import '../../../widgets/custom_widgets.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: NoDataPlaceholder(message: 'comming soon', ico: Icons.person_outline));
  }
}
