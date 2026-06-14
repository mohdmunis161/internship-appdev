import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HealthMetricCard extends StatelessWidget {
  final String title;
  final String val;
  final IconData ico;
  final Color clr;

  const HealthMetricCard({
    super.key, required this.title, required this.val,
    required this.ico, required this.clr,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Gaps.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: clr.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12)),
          child: Icon(ico, color: clr, size: 24),
        ),
        const SizedBox(width: Gaps.md),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.sub),
            const SizedBox(height: 2),
            Text(val, style: AppTypography.cap, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        )),
        const Icon(Icons.chevron_right, color: AppColors.txtSecondary, size: 20),
      ]),
    );
  }
}

// upcomming activity row
class ScheduleItem extends StatelessWidget {
  final String activity;
  final String time;
  final IconData ico;
  const ScheduleItem({super.key, required this.activity, required this.time, required this.ico});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gaps.sm),
      child: Row(children: [
        Icon(ico, size: 20, color: AppColors.primary),
        const SizedBox(width: Gaps.sm),
        Expanded(child: Text(activity, style: AppTypography.body.copyWith(fontWeight: FontWeight.w500))),
        Text(time, style: AppTypography.cap),
      ]),
    );
  }
}

// helth tip card with bg image
class HealthTipCard extends StatelessWidget {
  final String headline;
  final String imgUrl;
  const HealthTipCard({super.key, required this.headline, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10, offset: const Offset(0, 4))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(fit: StackFit.expand, children: [
        Image.network(imgUrl, fit: BoxFit.cover,
          errorBuilder: (ctx, e, st) => Container(color: AppColors.divider,
            child: const Icon(Icons.image_not_supported_outlined, color: AppColors.txtSecondary))),
        Container(decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)]))),
        Positioned(bottom: 16, left: 16, right: 16,
          child: Text(headline,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 2, overflow: TextOverflow.ellipsis)),
      ]),
    );
  }
}
