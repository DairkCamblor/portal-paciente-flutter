import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

/// Icono dentro de un contenedor tintado.
///
/// Es decorativo: se excluye de la semántica. El tamaño crece con la escala
/// de texto del sistema (hasta 1.5 veces) para mantener la proporción.
class IconTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final double size;

  const IconTile(
    this.icon, {
    super.key,
    this.color = AppColors.primary,
    this.backgroundColor = AppColors.primarySoft,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.textScalerOf(context).scale(size) / size;
    final factor = scale.clamp(1.0, 1.5);
    final boxSize = size * factor;

    return ExcludeSemantics(
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AppRadius.cardBorder,
        ),
        child: Icon(icon, size: size * 0.5 * factor, color: color),
      ),
    );
  }
}
