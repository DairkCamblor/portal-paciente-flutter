import 'package:flutter/material.dart';
import 'package:portal_paciente/models/prescription.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/icon_tile.dart';
import '../widgets/info_row.dart';
import '../widgets/portal_card.dart';
import '../widgets/section_header.dart';
import '../widgets/status_message.dart';

class PrescriptionDetailScreen extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionDetailScreen({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receta N.º ${prescription.id}')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          _PrescriptionHeader(prescription: prescription),

          const SizedBox(height: AppSpacing.xl),

          const SectionHeader('Medicamentos'),

          ...prescription.medications.map(
            (medication) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: _MedicationCard(medication: medication),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrescriptionHeader extends StatelessWidget {
  final Prescription prescription;

  const _PrescriptionHeader({required this.prescription});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PortalCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconTile(Icons.receipt_long_outlined, size: 52),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Receta médica', style: textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text('N.º ${prescription.id}', style: textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          const Divider(),

          const SizedBox(height: AppSpacing.md),

          InfoRow(
            icon: Icons.person_outline,
            label: 'Profesional',
            value: prescription.professional,
          ),

          InfoRow(
            icon: Icons.badge_outlined,
            label: 'RUN profesional',
            value: prescription.professionalRun,
          ),

          InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Local',
            value: prescription.location,
          ),

          InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Fecha de solicitud',
            value: prescription.requestDate,
          ),

          InfoRow(
            icon: Icons.event_available_outlined,
            label: 'Fecha de creación',
            value: prescription.creationDate,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final PrescriptionMedication medication;

  const _MedicationCard({required this.medication});

  @override
  Widget build(BuildContext context) {
    final bool complete = medication.fullyDelivered;

    return PortalCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconTile(
                Icons.medication_outlined,
                size: 48,
                color: AppColors.primary,
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Text(
                  medication.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          InfoRow(
            icon: Icons.inventory_2_outlined,
            label: 'Cantidad',
            value: '${medication.quantity} ${medication.unit}',
          ),

          InfoRow(
            icon: Icons.medical_information_outlined,
            label: 'Dosis',
            value: '${medication.dose} ${medication.unit}',
          ),

          InfoRow(
            icon: Icons.schedule_outlined,
            label: 'Frecuencia',
            value: medication.frequency,
          ),

          InfoRow(
            icon: Icons.date_range_outlined,
            label: 'Período',
            value: medication.period,
          ),

          InfoRow(
            icon: Icons.route_outlined,
            label: 'Vía',
            value: medication.administrationRoute,
          ),

          if (medication.observation.isNotEmpty)
            InfoRow(
              icon: Icons.info_outline,
              label: 'Observación',
              value: medication.observation,
            ),

          const SizedBox(height: AppSpacing.xs),

          StatusMessage(
            complete
                ? 'Entregado ${medication.deliveries}/${medication.totalDeliveries}'
                : 'Entrega pendiente '
                      '${medication.deliveries}/${medication.totalDeliveries}',
            style: complete ? AppColors.statusSigned : AppColors.statusPending,
          ),
        ],
      ),
    );
  }
}
