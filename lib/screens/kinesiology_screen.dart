import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../widgets/detail_sheet.dart';
import '../widgets/icon_tile.dart';
import '../widgets/info_row.dart';
import '../widgets/portal_card.dart';
import '../widgets/screen_header.dart';
import '../widgets/section_header.dart';
import '../widgets/status_badge.dart';
import '../widgets/status_message.dart';

class KinesiologyScreen extends StatelessWidget {
  const KinesiologyScreen({super.key});

  // Datos ficticios para el prototipo.
  // Más adelante estos datos vendrán desde la API del hospital.

  final List<KinesiologyTreatment> tratamientosActuales = const [
    KinesiologyTreatment(
      id: 'kine_001',
      especialidadOrigen: 'Traumatología',
      tipoProcedimiento: 'Músculo - Esquelético',
      estado: 'En tratamiento',
      sesionesRealizadas: 3,
      sesionesTotales: 10,
      proximaSesion: '15-09-2026',
      horaProximaSesion: '09:30',
      lugar: 'Hospital Regional',
    ),
    KinesiologyTreatment(
      id: 'kine_002',
      especialidadOrigen: 'Neurología',
      tipoProcedimiento: 'Neuro Rehabilitación',
      estado: 'Pendiente',
      sesionesRealizadas: 0,
      sesionesTotales: 8,
      proximaSesion: null,
      horaProximaSesion: null,
      lugar: null,
    ),
  ];

  final List<KinesiologyTreatment> tratamientosFinalizados = const [
    KinesiologyTreatment(
      id: 'kine_003',
      especialidadOrigen: 'Traumatología',
      tipoProcedimiento: 'Músculo - Esquelético',
      estado: 'Egresado',
      sesionesRealizadas: 10,
      sesionesTotales: 10,
      proximaSesion: null,
      horaProximaSesion: null,
      lugar: null,
    ),
    KinesiologyTreatment(
      id: 'kine_004',
      especialidadOrigen: 'Cardiología',
      tipoProcedimiento: 'Rehabilitación Cardio - Respiratoria',
      estado: 'Egresado',
      sesionesRealizadas: 8,
      sesionesTotales: 8,
      proximaSesion: null,
      horaProximaSesion: null,
      lugar: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kinesiología')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          const ScreenHeader.intro(
            'Consulta tus tratamientos y sesiones de rehabilitación.',
          ),

          // ─────────────────────────────────────
          // TRATAMIENTOS ACTUALES
          // ─────────────────────────────────────
          const SectionHeader(
            'Tratamientos actuales',
            icon: Icons.accessibility_new_outlined,
          ),

          ...tratamientosActuales.map(
            (tratamiento) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: _TreatmentCard(
                treatment: tratamiento,
                onTap: () {
                  _showDetails(context, tratamiento);
                },
              ),
            ),
          ),

          // ─────────────────────────────────────
          // TRATAMIENTOS FINALIZADOS
          // ─────────────────────────────────────
          const SizedBox(height: AppSpacing.sm),

          const SectionHeader(
            'Tratamientos finalizados',
            icon: Icons.check_circle_outline,
          ),

          ...tratamientosFinalizados.map(
            (tratamiento) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _CompletedTreatmentCard(
                treatment: tratamiento,
                onTap: () {
                  _showDetails(context, tratamiento);
                },
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'La información mostrada corresponde a datos registrados en los sistemas institucionales.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, KinesiologyTreatment treatment) {
    final bool egresado = treatment.estado == 'Egresado';

    showDetailSheet(
      context,
      title: 'Kinesiología',
      icon: Icons.directions_run_outlined,
      children: [
        InfoRow(
          icon: Icons.info_outline,
          label: 'Estado',
          value: treatment.estado,
        ),

        InfoRow(
          icon: Icons.medical_services_outlined,
          label: 'Especialidad de origen',
          value: treatment.especialidadOrigen,
        ),

        InfoRow(
          icon: Icons.accessibility_new_outlined,
          label: 'Tipo de procedimiento',
          value: treatment.tipoProcedimiento,
        ),

        InfoRow(
          icon: Icons.confirmation_number_outlined,
          label: 'Sesiones',
          value:
              '${treatment.sesionesRealizadas} de ${treatment.sesionesTotales} realizadas',
        ),

        if (!egresado && treatment.proximaSesion != null) ...[
          InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Próxima sesión',
            value: treatment.proximaSesion!,
          ),
          InfoRow(
            icon: Icons.access_time,
            label: 'Hora',
            value: treatment.horaProximaSesion ?? '',
          ),
        ],

        if (!egresado && treatment.lugar != null)
          InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Lugar',
            value: treatment.lugar!,
          ),

        if (egresado)
          const StatusMessage(
            'Tratamiento finalizado.',
            style: AppColors.statusSigned,
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// MODELO DE KINESIOLOGÍA
// ─────────────────────────────────────────────

class KinesiologyTreatment {
  final String id;
  final String especialidadOrigen;
  final String tipoProcedimiento;
  final String estado;
  final int sesionesRealizadas;
  final int sesionesTotales;
  final String? proximaSesion;
  final String? horaProximaSesion;
  final String? lugar;

  const KinesiologyTreatment({
    required this.id,
    required this.especialidadOrigen,
    required this.tipoProcedimiento,
    required this.estado,
    required this.sesionesRealizadas,
    required this.sesionesTotales,
    required this.proximaSesion,
    required this.horaProximaSesion,
    required this.lugar,
  });
}

// ─────────────────────────────────────────────
// TARJETA TRATAMIENTO ACTUAL
// ─────────────────────────────────────────────

class _TreatmentCard extends StatelessWidget {
  final KinesiologyTreatment treatment;
  final VoidCallback onTap;

  const _TreatmentCard({required this.treatment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final double progreso = treatment.sesionesTotales == 0
        ? 0
        : treatment.sesionesRealizadas / treatment.sesionesTotales;

    final int pendientes =
        treatment.sesionesTotales - treatment.sesionesRealizadas;

    return PortalCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconTile(Icons.directions_run_outlined, size: 52),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kinesiología', style: textTheme.titleSmall),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      treatment.especialidadOrigen,
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    StatusBadge(treatment.estado),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          const Divider(),

          const SizedBox(height: AppSpacing.md),

          InfoRow(
            icon: Icons.accessibility_new_outlined,
            label: 'Tipo de procedimiento',
            value: treatment.tipoProcedimiento,
          ),

          Text('Sesiones', style: textTheme.labelMedium),

          const SizedBox(height: AppSpacing.xs),

          Text(
            '${treatment.sesionesRealizadas} de ${treatment.sesionesTotales} realizadas',
            style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
          ),

          const SizedBox(height: AppSpacing.md),

          Semantics(
            label: 'Progreso del tratamiento',
            value: '${(progreso * 100).round()} por ciento',
            child: ClipRRect(
              borderRadius: AppRadius.pillBorder,
              child: LinearProgressIndicator(value: progreso, minHeight: 10),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text('$pendientes sesiones pendientes', style: textTheme.bodySmall),

          if (treatment.proximaSesion != null) ...[
            const SizedBox(height: AppSpacing.lg),

            InfoRow(
              icon: Icons.event_outlined,
              label: 'Próxima sesión',
              value:
                  '${treatment.proximaSesion} • ${treatment.horaProximaSesion}',
            ),
          ],

          if (treatment.lugar != null)
            InfoRow(
              icon: Icons.location_on_outlined,
              label: 'Lugar',
              value: treatment.lugar!,
            ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward),
              iconAlignment: IconAlignment.end,
              label: const Text('Ver detalle'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TARJETA TRATAMIENTO FINALIZADO
// ─────────────────────────────────────────────

class _CompletedTreatmentCard extends StatelessWidget {
  final KinesiologyTreatment treatment;
  final VoidCallback onTap;

  const _CompletedTreatmentCard({required this.treatment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PortalCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconTile(
            Icons.check_circle_outline,
            size: 52,
            color: AppColors.successText,
            backgroundColor: AppColors.successSoft,
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kinesiología', style: textTheme.titleSmall),

                const SizedBox(height: AppSpacing.xs),

                Text(treatment.especialidadOrigen, style: textTheme.bodySmall),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  '${treatment.sesionesRealizadas} de ${treatment.sesionesTotales} sesiones realizadas',
                  style: textTheme.bodySmall,
                ),

                const SizedBox(height: AppSpacing.sm),

                StatusBadge(treatment.estado),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
