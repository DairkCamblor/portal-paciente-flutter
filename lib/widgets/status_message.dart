import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

/// Mensaje destacado con fondo tintado (entrega completa, en espera, etc.).
///
/// Usa los pares de color de [AppColors] para mantener el contraste. El texto
/// puede ocupar varias líneas.
class StatusMessage extends StatelessWidget {
  final String text;
  final StatusStyle style;

  /// Si es null se usa el icono asociado al [style].
  final IconData? icon;

  const StatusMessage(this.text, {super.key, required this.style, this.icon});

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.textScalerOf(context).scale(24);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: AppRadius.controlBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: Icon(
              icon ?? style.icon,
              size: iconSize,
              color: style.foreground,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: style.foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
