import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'icon_tile.dart';
import 'portal_card.dart';

/// Tarjeta de acceso a una categoría: icono, título, descripción opcional y
/// flecha. Se adapta a títulos largos y a texto ampliado.
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PortalCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Row(
        children: [
          IconTile(icon),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.titleSmall),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(subtitle!, style: textTheme.bodySmall),
                ],
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 28,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
