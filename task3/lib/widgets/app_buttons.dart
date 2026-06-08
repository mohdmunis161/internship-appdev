import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PrimaryBtn extends StatelessWidget {
  final String lbl;
  final VoidCallback? onPressed;
  final bool loading;

  const PrimaryBtn({super.key, required this.lbl, this.onPressed, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 52,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: loading
          ? const SizedBox(height: 22, width: 22,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
          : Text(lbl, style: AppTypography.btn),
      ),
    );
  }
}

class SecondaryBtn extends StatelessWidget {
  final String lbl;
  final VoidCallback? onPressed;
  const SecondaryBtn({super.key, required this.lbl, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surface, foregroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.divider)),
        ),
        child: Text(lbl, style: AppTypography.btn),
      ),
    );
  }
}

class OutlinedBtn extends StatelessWidget {
  final String lbl;
  final VoidCallback? onPressed;
  final IconData? ico;
  const OutlinedBtn({super.key, required this.lbl, this.onPressed, this.ico});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 48, child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (ico != null) ...[Icon(ico, size: 20), const SizedBox(width: 8)],
        Text(lbl, style: AppTypography.btn),
      ]),
    ));
  }
}

class IconBtn extends StatelessWidget {
  final IconData ico;
  final VoidCallback? onTap;
  const IconBtn({super.key, required this.ico, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(Gaps.sm),
        child: Icon(ico, color: AppColors.txtSecondary, size: 24),
      ),
    );
  }
}
