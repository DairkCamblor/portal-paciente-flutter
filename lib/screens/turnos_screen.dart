import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/detail_sheet.dart';
import '../widgets/icon_tile.dart';
import '../widgets/info_row.dart';
import '../widgets/portal_card.dart';
import '../widgets/screen_header.dart';
import '../widgets/status_message.dart';

class TurnosScreen extends StatefulWidget {
  const TurnosScreen({super.key});

  @override
  State<TurnosScreen> createState() => _TurnosScreenState();
}

class _TurnosScreenState extends State<TurnosScreen> {
  bool turnoActivo = false;

  void _obtenerTurno() {
    setState(() {
      turnoActivo = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Turno generado correctamente.')),
    );
  }

  void _verDetalleTurno() {
    showDetailSheet(
      context,
      title: 'Detalle de tu turno',
      icon: Icons.confirmation_number_outlined,
      children: const [
        InfoRow(
          icon: Icons.confirmation_number_outlined,
          label: 'Número de turno',
          value: 'A-024',
        ),
        InfoRow(
          icon: Icons.medical_services_outlined,
          label: 'Atención',
          value: 'Medicina General',
        ),
        InfoRow(
          icon: Icons.location_on_outlined,
          label: 'Lugar',
          value: 'Hospital Regional',
        ),
        InfoRow(
          icon: Icons.access_time_outlined,
          label: 'Hora estimada',
          value: '09:30',
        ),
        SizedBox(height: AppSpacing.sm),
        StatusMessage(
          'Tu turno se encuentra en espera de atención.',
          style: AppColors.statusSigned,
          icon: Icons.info_outline,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Turnos de atención')),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScreenHeader.intro(
                  'Obtén y consulta tu turno de atención.',
                ),

                if (!turnoActivo)
                  PortalCard(
                    margin: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const IconTile(Icons.confirmation_number_outlined),
                            const SizedBox(width: AppSpacing.lg),
                            Expanded(
                              child: Text(
                                'Obtén tu turno',
                                style: textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppSpacing.lg),

                        Text(
                          'Puedes solicitar un turno digital para tu próxima atención en el hospital.',
                          style: textTheme.bodyMedium,
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: _obtenerTurno,
                            icon: const Icon(
                              Icons.confirmation_number_outlined,
                            ),
                            label: const Text('Obtener turno'),
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  PortalCard(
                    margin: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: AppColors.success,
                              size: MediaQuery.textScalerOf(context).scale(28),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                'Tienes un turno activo',
                                style: textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        Center(
                          child: Column(
                            children: [
                              Text('Tu turno', style: textTheme.labelMedium),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'A-024',
                                style: textTheme.headlineSmall?.copyWith(
                                  fontSize: 48,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Medicina General',
                                textAlign: TextAlign.center,
                                style: textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        const StatusMessage(
                          'En espera de atención',
                          style: AppColors.statusPending,
                          icon: Icons.hourglass_empty,
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        const InfoRow(
                          icon: Icons.location_on_outlined,
                          label: 'Lugar',
                          value: 'Hospital Regional',
                        ),

                        const InfoRow(
                          icon: Icons.access_time_outlined,
                          label: 'Hora estimada',
                          value: '09:30',
                        ),

                        const SizedBox(height: AppSpacing.sm),

                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _verDetalleTurno,
                            icon: const Icon(Icons.visibility_outlined),
                            label: const Text('Ver detalle'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  PortalCard(
                    margin: EdgeInsets.zero,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primary,
                          size: MediaQuery.textScalerOf(context).scale(24),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            'Este turno es una demostración del funcionamiento del módulo.',
                            style: textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
