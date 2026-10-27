import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

/// Insignia de estado (Pendiente, En tratamiento, Agendado, Egresado, Firmado...).
///
/// El color se obtiene de [AppColors.statusStyle] a partir del texto, o puede
/// forzarse con [style]. Incluye un icono para que el estado no dependa solo
/// del color. El texto puede ocupar varias líneas con letra grande.
class StatusBadge extends StatelessWidget {
  final String status;
  final StatusStyle? style;

  const StatusBadge(this.status, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final resolved = style ?? AppColors.statusStyle(status);
    final textStyle = Theme.of(
      context,
    ).textTheme.labelSmall?.copyWith(color: resolved.foreground);
    final iconSize = MediaQuery.textScalerOf(context).scale(16);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: resolved.background,
        borderRadius: AppRadius.pillBorder,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: Icon(
                resolved.icon,
                size: iconSize,
                color: resolved.foreground,
              ),
            ),
            const SizedBox(width: 6),
            Flexible(child: Text(status, style: textStyle)),
          ],
        ),
      ),
    );
  }
}
