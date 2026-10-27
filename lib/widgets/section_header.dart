import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Encabezado de sección dentro de una pantalla.
///
/// [icon] muestra un icono a la izquierda del título; el título se ajusta en
/// varias líneas si no cabe. [trailing] admite una acción opcional alineada a
/// la derecha (por ejemplo un botón "Editar"); si no cabe en la misma línea,
/// pasa debajo del título.
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const SectionHeader(
    this.title, {
    super.key,
    this.icon,
    this.trailing,
    this.padding = const EdgeInsets.only(bottom: AppSpacing.md),
  });

  @override
  Widget build(BuildContext context) {
    final text = Semantics(
      header: true,
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );

    final titleWidget = icon == null
        ? text
        : Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExcludeSemantics(
                child: Icon(
                  icon,
                  size: MediaQuery.textScalerOf(context).scale(24),
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Flexible(child: text),
            ],
          );

    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: trailing == null
            ? titleWidget
            : Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: AppSpacing.xs,
                children: [titleWidget, trailing!],
              ),
      ),
    );
  }
}
