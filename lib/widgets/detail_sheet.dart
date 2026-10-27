import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'icon_tile.dart';

/// Hoja inferior de detalle con título, contenido y botón "Cerrar".
///
/// El contenido es desplazable, por lo que no desborda con texto ampliado ni
/// con el teclado abierto. [actions] se muestran antes del botón "Cerrar".
Future<void> showDetailSheet(
  BuildContext context, {
  required String title,
  required IconData icon,
  required List<Widget> children,
  List<Widget> actions = const [],
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    constraints: const BoxConstraints(maxWidth: 640),
    builder: (context) {
      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconTile(icon, size: 52),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              ...children,

              const SizedBox(height: AppSpacing.xs),

              for (final action in actions) ...[
                action,
                const SizedBox(height: AppSpacing.sm),
              ],

              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
