import 'package:flutter/material.dart';

import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

/// Tarjeta base del portal. Toma color, borde y forma del `cardTheme`.
///
/// No tiene altura fija: se ajusta a su contenido y al tamaño de texto.
/// Si recibe [onTap], toda la tarjeta es táctil.
class PortalCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  /// Margen exterior. Si es null se usa el margen por defecto de `Card`.
  final EdgeInsetsGeometry? margin;

  const PortalCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = AppSpacing.cardPadding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.cardBorder,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
