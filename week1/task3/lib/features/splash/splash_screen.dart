import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashState();
}

class SplashState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController animCtrl;
  late final Animation<double> fadeAnim;

  @override
  void initState() {
    super.initState();
    animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    fadeAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animCtrl, curve: Curves.easeIn));
    animCtrl.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF2D2D2D), Color(0xFF1A1A1A)])),
        child: FadeTransition(
          opacity: fadeAnim,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90, height: 90,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(24)),
                child: const Icon(Icons.favorite_rounded, size: 48, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text('Pulse', style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2)),
              const SizedBox(height: 8),
              Text('Your health companion',
                style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.8))),
              const SizedBox(height: 48),
              SizedBox(width: 28, height: 28,
                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ),
    );
  }
}
