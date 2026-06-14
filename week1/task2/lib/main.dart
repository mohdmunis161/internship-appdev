import 'package:flutter/material.dart';
import 'features/splash/splash_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/home/main_dashboard.dart';

void main() {
  // Start the application
  runApp(const PulseApp());
}

class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse App',
      debugShowCheckedModeBanner: false,
      // Define standard theme colors
      theme: ThemeData(
        primaryColor: const Color(0xFF1A1A1A),
      ),
      // Set up routes for Task 2
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainDashboard(), // Route to the dashboard with nav
      },
    );
  }
}
