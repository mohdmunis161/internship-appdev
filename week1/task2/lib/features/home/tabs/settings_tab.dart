import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'App Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        _buildSwitchTile('Push Notifications', true),
        const Divider(),
        _buildSwitchTile('Dark Mode', false),
        const Divider(),
        _buildSwitchTile('Location Services', true),
        const SizedBox(height: 30),
        const Text(
          'Account',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Change Password'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSwitchTile(String title, bool value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: (bool newValue) {},
        activeColor: const Color(0xFF1A1A1A),
      ),
    );
  }
}
