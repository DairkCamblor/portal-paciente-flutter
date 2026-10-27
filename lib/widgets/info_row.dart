import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Fila de información: icono, etiqueta y valor.
///
/// Sirve de reemplazo común para las filas de detalle de cada pantalla.
/// El texto se ajusta en varias líneas y el icono sigue la escala de texto.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final EdgeInsetsGeometry padding;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.padding = const EdgeInsets.only(bottom: AppSpacing.md),
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconSize = MediaQuery.textScalerOf(context).scale(24);

    return Padding(
      padding: padding,
      child: Semantics(
        container: true,
        label: '$label: $value',
        excludeSemantics: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: iconSize, color: AppColors.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: textTheme.labelMedium),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
