import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_widgets.dart';
import 'tabs/home_tab.dart';
import 'tabs/profile_tab.dart';
import 'tabs/settings_tab.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => DashState();
}

class DashState extends State<MainDashboard> {
  var tabIndex = 0;

  static const tabLabels = ['Dashboard', 'Profile', 'Settings'];
  static const tabPages = <Widget>[HomeTab(), ProfileTab(), SettingsTab()];

  void onTabTap(int i) {
    if (i == tabIndex) return;
    setState(() => tabIndex = i);
  }

  void navToTab(int i) {
    Navigator.pop(context);
    onTabTap(i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tabLabels[tabIndex]),
        leading: Builder(builder: (c) => IconButton(
          icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(c).openDrawer())),
      ),
      drawer: buildDrawer(),
      body: IndexedStack(index: tabIndex, children: tabPages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex, onTap: onTabTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.bg,
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: AppColors.primary),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const UserProfileAvatar(name: 'Munis', sz: 56),
              const SizedBox(height: 12),
              Text('Munis', style: AppTypography.sub.copyWith(color: Colors.white)),
              Text('munis@example.com', style: AppTypography.cap.copyWith(color: Colors.white70)),
            ],
          ),
        ),
        ListTile(leading: const Icon(Icons.home), title: const Text('Home'), onTap: () => navToTab(0)),
        ListTile(leading: const Icon(Icons.person), title: const Text('Profile'), onTap: () => navToTab(1)),
        ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'), onTap: () => navToTab(2)),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: AppColors.err),
          title: const Text('Logout', style: TextStyle(color: AppColors.err)),
          onTap: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      ]),
    );
  }
}
