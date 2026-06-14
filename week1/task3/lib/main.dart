import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/home/main_dashboard.dart';

void main() => runApp(const PulseApp());

class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      onGenerateRoute: genRoute,
    );
  }

  Route? genRoute(RouteSettings s) {
    final pages = <String, Widget>{
      '/': const SplashScreen(),
      '/login': const LoginScreen(),
      '/home': const MainDashboard(),
    };
    var pg = pages[s.name] ?? const SplashScreen();

    return PageRouteBuilder(
      settings: s,
      pageBuilder: (ctx, a, sa) => pg,
      transitionsBuilder: (ctx, a, sa, child) => FadeTransition(opacity: a, child: child),
    );
  }
}
