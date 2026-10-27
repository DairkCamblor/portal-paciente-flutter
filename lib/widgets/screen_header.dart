import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Título principal de una pantalla con subtítulo opcional.
///
/// Con [ScreenHeader.intro] se muestra solo el texto de apoyo, para pantallas
/// cuyo título ya aparece en el AppBar y no debe repetirse.
class ScreenHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final EdgeInsetsGeometry padding;

  const ScreenHeader(
    String this.title, {
    super.key,
    this.subtitle,
    this.padding = const EdgeInsets.only(bottom: AppSpacing.xl),
  });

  const ScreenHeader.intro(
    String text, {
    super.key,
    this.padding = const EdgeInsets.only(bottom: AppSpacing.xl),
  }) : title = null,
       subtitle = text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final onlyIntro = title == null;

    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Semantics(
                header: true,
                child: Text(title!, style: textTheme.headlineSmall),
              ),
            if (subtitle != null) ...[
              if (!onlyIntro) const SizedBox(height: AppSpacing.sm),
              Text(
                subtitle!,
                style: textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
