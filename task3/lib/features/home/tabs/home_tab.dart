import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/app_cards.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  static const int goalSteps = 10000;
  static const int currSteps = 7500;

  @override
  Widget build(BuildContext context) {
    double progress = currSteps / goalSteps;

    return ListView(
      padding: const EdgeInsets.all(Gaps.md),
      children: [
        buildTracker(progress),
        const SizedBox(height: Gaps.lg),

        const Text('Daily Summary', style: AppTypography.h2),
        const SizedBox(height: Gaps.md),

        const HealthMetricCard(title: 'Heart Rate', val: '72 bpm (Resting)', ico: Icons.favorite_rounded, clr: Color(0xFFE55D5D)),
        const SizedBox(height: Gaps.sm),
        const HealthMetricCard(title: 'Sleep Quality', val: '7h 20m (Good)', ico: Icons.bedtime_rounded, clr: Color(0xFF1A1A1A)),

        const SizedBox(height: Gaps.lg),
        const Text('Upcoming Activity', style: AppTypography.h2),
        const SizedBox(height: Gaps.md),

        const ScheduleItem(activity: 'Morning Run', time: '08:00 AM', ico: Icons.directions_run_rounded),
        const ScheduleItem(activity: 'Yoga Session', time: '06:00 PM', ico: Icons.self_improvement_rounded),
      ],
    );
  }

  Widget buildTracker(double progVal) {
    return Container(
      padding: const EdgeInsets.all(Gaps.lg),
      decoration: BoxDecoration(
        color: AppColors.surface, borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 24, offset: const Offset(0, 8))]),
      child: Column(children: [
        const Text('Activity Goal', style: AppTypography.sub),
        const SizedBox(height: Gaps.lg),
        Stack(alignment: Alignment.center, children: [
          SizedBox(
            width: 160, height: 160,
            child: CircularProgressIndicator(
              value: progVal, strokeWidth: 16,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15), color: AppColors.primary, strokeCap: StrokeCap.round)),
          Column(mainAxisSize: MainAxisSize.min, children: [
            Text('$currSteps', style: AppTypography.h1),
            Text('of $goalSteps steps', style: AppTypography.cap),
          ]),
        ]),
      ]),
    );
  }
}
