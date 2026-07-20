import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;
  final IconData? icon;

  const StatusPill({
    super.key,
    required this.label,
    required this.color,
    required this.background,
    this.icon,
  });

  factory StatusPill.confirmed([String label = 'Confirmé']) => StatusPill(
        label: label,
        color: AppColors.success,
        background: AppColors.successBg,
        icon: Icons.check_circle_rounded,
      );

  factory StatusPill.pending([String label = 'En attente']) => StatusPill(
        label: label,
        color: AppColors.warning,
        background: AppColors.warningBg,
        icon: Icons.access_time_rounded,
      );

  factory StatusPill.cancelled([String label = 'Annulé']) => StatusPill(
        label: label,
        color: AppColors.danger,
        background: AppColors.dangerBg,
        icon: Icons.cancel_rounded,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: color, size: 13),
            const SizedBox(width: 4),
          ],
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12)),
        ],
      ),
    );
  }
}
