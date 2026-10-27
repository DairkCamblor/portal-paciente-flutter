import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

/// Banda institucional superior para las pantallas de acceso.
///
/// Usa un icono genérico como marcador provisional: no es el logo oficial
/// del hospital y debe reemplazarse cuando exista la identidad definitiva.
/// Se dibuja bajo la barra de estado, por lo que no requiere `SafeArea`
/// superior.
class BrandHeader extends StatelessWidget {
  /// Versión reducida para pantallas con formulario.
  final bool compact;

  const BrandHeader({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Semantics(
        container: true,
        label: 'Hospital Regional Dr. Juan Noé Crevani',
        excludeSemantics: true,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            AppSpacing.xl,
            topInset + (compact ? AppSpacing.lg : AppSpacing.xxl),
            AppSpacing.xl,
            compact ? AppSpacing.xl : AppSpacing.xxl,
          ),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(AppRadius.card * 2),
            ),
          ),
          child: Column(
            children: [
              _BrandMark(compact: compact),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Hospital Regional',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textOnPrimary,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Dr. Juan Noé Crevani',
                textAlign: TextAlign.center,
                style: (compact ? textTheme.titleSmall : textTheme.titleMedium)
                    ?.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Icono provisional sobre fondo blanco, escalable con el texto.
class _BrandMark extends StatelessWidget {
  final bool compact;

  const _BrandMark({required this.compact});

  @override
  Widget build(BuildContext context) {
    final base = compact ? 56.0 : 80.0;
    final factor = (MediaQuery.textScalerOf(context).scale(base) / base).clamp(
      1.0,
      1.4,
    );
    final size = base * factor;

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.local_hospital,
        size: size * 0.55,
        color: AppColors.primary,
      ),
    );
  }
}
