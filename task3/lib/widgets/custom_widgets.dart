import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class UserProfileAvatar extends StatelessWidget {
  final String name;
  final double sz;
  const UserProfileAvatar({super.key, required this.name, this.sz = 48});

  @override
  Widget build(BuildContext context) {
    String ltr = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width: sz, height: sz,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(ltr, style: TextStyle(
        color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: sz * 0.4)),
    );
  }
}

class HealthStatusBadge extends StatelessWidget {
  final String txt;
  final Color? clr;
  const HealthStatusBadge({super.key, required this.txt, this.clr});

  @override
  Widget build(BuildContext context) {
    final c = clr ?? AppColors.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
      child: Text(txt, style: AppTypography.cap.copyWith(color: c, fontWeight: FontWeight.bold)),
    );
  }
}

// filter pills for activity catogories
class ActivityFilter extends StatelessWidget {
  final String lbl;
  final bool active;
  final VoidCallback onTap;
  const ActivityFilter({super.key, required this.lbl, this.active = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? AppColors.primary : AppColors.divider),
        ),
        child: Text(lbl, style: AppTypography.body.copyWith(
          color: active ? Colors.white : AppColors.txtPrimary)),
      ),
    );
  }
}

// shows when theres no data on a tab
class NoDataPlaceholder extends StatelessWidget {
  final String message;
  final IconData ico;
  const NoDataPlaceholder({super.key, required this.message, this.ico = Icons.folder_open});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(ico, size: 64, color: AppColors.divider),
        const SizedBox(height: 16),
        Text(message, style: AppTypography.sub, textAlign: TextAlign.center),
      ],
    ));
  }
}
