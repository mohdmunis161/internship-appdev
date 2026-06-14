import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// pull to refresh list with sections
class RefreshableSectionList extends StatelessWidget {
  final Map<String, List<Widget>> secs;
  final Future<void> Function() onRef;

  const RefreshableSectionList({super.key, required this.secs, required this.onRef});

  @override
  Widget build(BuildContext context) {
    var hdrs = secs.keys.toList();

    return RefreshIndicator(
      onRefresh: onRef, color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: Gaps.md),
        itemCount: hdrs.length,
        itemBuilder: (ctx, i) {
          String hd = hdrs[i];
          List<Widget> items = secs[hd]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Gaps.md, vertical: Gaps.sm),
                child: Text(hd, style: AppTypography.h2),
              ),
              for (final itm in items)
                Padding(padding: const EdgeInsets.symmetric(horizontal: Gaps.md), child: itm),
              const SizedBox(height: Gaps.lg),
            ],
          );
        },
      ),
    );
  }
}
