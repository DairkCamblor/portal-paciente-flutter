import 'package:flutter/material.dart';
import 'package:portal_paciente/models/prescription.dart';

class PrescriptionDetailScreen extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionDetailScreen({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receta N.º ${prescription.id}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _PrescriptionHeader(prescription: prescription),

          const SizedBox(height: 20),

          const Text(
            'Medicamentos',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          ...prescription.medications.map(
            (medication) => _MedicationCard(medication: medication),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.receipt_long_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Receta médica',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'N.º ${prescription.id}',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 28),

            _InfoRow(
              icon: Icons.person_outline,
              label: 'Profesional',
              value: prescription.professional,
            ),

            const SizedBox(height: 10),

            _InfoRow(
              icon: Icons.badge_outlined,
              label: 'RUN profesional',
              value: prescription.professionalRun,
            ),

            const SizedBox(height: 10),

            _InfoRow(
              icon: Icons.location_on_outlined,
              label: 'Local',
              value: prescription.location,
            ),

            const SizedBox(height: 10),

            _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Fecha de solicitud',
              value: prescription.requestDate,
            ),

            const SizedBox(height: 10),

            _InfoRow(
              icon: Icons.event_available_outlined,
              label: 'Fecha de creación',
              value: prescription.creationDate,
            ),
          ],
        ),
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

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.medication_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    medication.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _InfoRow(
              icon: Icons.inventory_2_outlined,
              label: 'Cantidad',
              value: '${medication.quantity} ${medication.unit}',
            ),

            const SizedBox(height: 8),

            _InfoRow(
              icon: Icons.medical_information_outlined,
              label: 'Dosis',
              value: '${medication.dose} ${medication.unit}',
            ),

            const SizedBox(height: 8),

            _InfoRow(
              icon: Icons.schedule_outlined,
              label: 'Frecuencia',
              value: medication.frequency,
            ),

            const SizedBox(height: 8),

            _InfoRow(
              icon: Icons.date_range_outlined,
              label: 'Período',
              value: medication.period,
            ),

            const SizedBox(height: 8),

            _InfoRow(
              icon: Icons.route_outlined,
              label: 'Vía',
              value: medication.administrationRoute,
            ),

            if (medication.observation.isNotEmpty) ...[
              const SizedBox(height: 8),

              _InfoRow(
                icon: Icons.info_outline,
                label: 'Observación',
                value: medication.observation,
              ),
            ],

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: complete
                    ? Colors.green.withValues(alpha: 0.08)
                    : Colors.orange.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    complete
                        ? Icons.check_circle_outline
                        : Icons.pending_actions_outlined,
                    color: complete
                        ? Colors.green.shade700
                        : Colors.orange.shade800,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      complete
                          ? 'Entregado ${medication.deliveries}/${medication.totalDeliveries}'
                          : 'Entrega pendiente '
                                '${medication.deliveries}/${medication.totalDeliveries}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: complete
                            ? Colors.green.shade800
                            : Colors.orange.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 19, color: Theme.of(context).colorScheme.primary),

        const SizedBox(width: 10),

        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
