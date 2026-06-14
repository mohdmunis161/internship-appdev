import 'package:flutter/material.dart';
import 'tabs/home_tab.dart';
import 'tabs/profile_tab.dart';
import 'tabs/settings_tab.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  // Controller to preserve navigation state and handle animations
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the page controller
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    // Clean up the controller
    _pageController.dispose();
    super.dispose();
  }

  // Handle bottom navigation tap
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Smoothly animate to the new page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Handle drawer navigation
  void _onDrawerItemTapped(int index) {
    Navigator.pop(context); // Close the drawer
    if (index == 3) {
      // Handle logout
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    _onTabTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulse App'),
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      // Side drawer for navigation
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1A1A1A),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Mohd Munis',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'munis@example.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () => _onDrawerItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => _onDrawerItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _onDrawerItemTapped(2),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => _onDrawerItemTapped(3),
            ),
          ],
        ),
      ),
      // Page view to preserve state across tabs
      body: PageView(
        controller: _pageController,
        // Disable swipe to match standard bottom nav behavior
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeTab(),
          ProfileTab(),
          SettingsTab(),
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: const Color(0xFF1A1A1A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
