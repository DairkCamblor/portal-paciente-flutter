import 'package:flutter/material.dart';

import 'package:portal_paciente/models/prescription.dart';

import 'prescription_detail_screen.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/icon_tile.dart';
import '../widgets/portal_card.dart';
import '../widgets/status_message.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  final List<Prescription> recetas = const [
    Prescription(
      id: '886724',
      professional: 'Dra. Carolina Morales Cozzi',
      professionalRun: '28793737-7',
      location: 'HJNC - Salud del Personal',
      requestDate: '17-06-2026',
      creationDate: '17-06-2026',
      medications: [
        PrescriptionMedication(
          name: 'Paracetamol 500 mg',
          quantity: '90',
          dose: '2',
          unit: 'comprimidos',
          frequency: 'Cada 8 horas',
          period: '15 días',
          administrationRoute: 'Vía oral',
          observation: 'Máximo 5 días por crisis',
          deliveries: 1,
          totalDeliveries: 1,
        ),
        PrescriptionMedication(
          name: 'Amitriptilina 25 mg',
          quantity: '90',
          dose: '1',
          unit: 'comprimido',
          frequency: 'En la noche',
          period: '3 meses',
          administrationRoute: 'Vía oral',
          observation: '',
          deliveries: 1,
          totalDeliveries: 1,
        ),
        PrescriptionMedication(
          name: 'Propranolol 10 mg',
          quantity: '90',
          dose: '1',
          unit: 'comprimido',
          frequency: 'Cada 24 horas',
          period: '3 meses',
          administrationRoute: 'Vía oral',
          observation: 'A medio día',
          deliveries: 1,
          totalDeliveries: 1,
        ),
        PrescriptionMedication(
          name: 'Ciclobenzaprina 10 mg',
          quantity: '10',
          dose: '1',
          unit: 'comprimido',
          frequency: 'En la noche',
          period: '10 días',
          administrationRoute: 'Vía oral',
          observation: '',
          deliveries: 1,
          totalDeliveries: 1,
        ),
        PrescriptionMedication(
          name: 'Ketoprofeno 150 mg',
          quantity: '45',
          dose: '1',
          unit: 'comprimido',
          frequency: 'Cada 8 horas',
          period: '15 días',
          administrationRoute: 'Vía oral',
          observation: '',
          deliveries: 0,
          totalDeliveries: 1,
        ),
      ],
    ),

    Prescription(
      id: '810245',
      professional: 'Dra. Carolina Morales Cozzi',
      professionalRun: '28793737-7',
      location: 'HJNC - Salud del Personal',
      requestDate: '26-11-2025',
      creationDate: '26-11-2025',
      medications: [
        PrescriptionMedication(
          name: 'Paracetamol 500 mg',
          quantity: '60',
          dose: '1',
          unit: 'comprimido',
          frequency: 'Cada 8 horas',
          period: '10 días',
          administrationRoute: 'Vía oral',
          observation: '',
          deliveries: 1,
          totalDeliveries: 1,
        ),
        PrescriptionMedication(
          name: 'Ibuprofeno 400 mg',
          quantity: '30',
          dose: '1',
          unit: 'comprimido',
          frequency: 'Cada 8 horas',
          period: '5 días',
          administrationRoute: 'Vía oral',
          observation: '',
          deliveries: 0,
          totalDeliveries: 1,
        ),
      ],
    ),

    Prescription(
      id: '557970',
      professional: 'Dr. Rodolfo Ortega Flores',
      professionalRun: '10973592-2',
      location: 'HJNC - Odontología',
      requestDate: '02-02-2024',
      creationDate: '02-02-2024',
      medications: [
        PrescriptionMedication(
          name: 'Amoxicilina 500 mg',
          quantity: '21',
          dose: '1',
          unit: 'cápsula',
          frequency: 'Cada 8 horas',
          period: '7 días',
          administrationRoute: 'Vía oral',
          observation: '',
          deliveries: 1,
          totalDeliveries: 1,
        ),
      ],
    ),

    Prescription(
      id: '26782',
      professional: 'Profesional solicitante',
      professionalRun: '-',
      location: 'HJNC',
      requestDate: '10-12-2019',
      creationDate: '10-12-2019',
      medications: [
        PrescriptionMedication(
          name: 'Medicamento de ejemplo',
          quantity: '20',
          dose: '1',
          unit: 'comprimido',
          frequency: 'Cada 12 horas',
          period: '10 días',
          administrationRoute: 'Vía oral',
          observation: '',
          deliveries: 0,
          totalDeliveries: 1,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Recetas')),
      body: ListView.builder(
        padding: AppSpacing.screenPadding,
        itemCount: recetas.length,
        itemBuilder: (context, index) {
          final receta = recetas[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: _PrescriptionCard(
              prescription: receta,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PrescriptionDetailScreen(prescription: receta),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  final Prescription prescription;
  final VoidCallback onTap;

  const _PrescriptionCard({required this.prescription, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final bool allDelivered = prescription.pendingMedications == 0;

    return PortalCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconTile(Icons.medication_outlined, size: 52),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Receta N.º ${prescription.id}',
                      style: textTheme.titleSmall,
                    ),

                    const SizedBox(height: AppSpacing.xs),

                    Text(prescription.requestDate, style: textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          const Divider(),

          const SizedBox(height: AppSpacing.md),

          Text(
            prescription.professional,
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(prescription.location, style: textTheme.bodySmall),

          const SizedBox(height: AppSpacing.lg),

          StatusMessage(
            '${prescription.deliveredMedications} '
            'de ${prescription.totalMedications} '
            'medicamentos completamente entregados',
            style: allDelivered
                ? AppColors.statusSigned
                : AppColors.statusPending,
          ),

          const SizedBox(height: AppSpacing.sm),

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
