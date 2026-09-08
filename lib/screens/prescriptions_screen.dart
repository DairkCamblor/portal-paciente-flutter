import 'package:flutter/material.dart';
import 'package:portal_paciente/models/prescription.dart';
import 'prescription_detail_screen.dart';

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
        padding: const EdgeInsets.all(16),
        itemCount: recetas.length,
        itemBuilder: (context, index) {
          final receta = recetas[index];

          return _PrescriptionCard(
            receta: receta,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PrescriptionDetailScreen(prescription: receta),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  final Prescription receta;
  final VoidCallback onTap;

  const _PrescriptionCard({required this.receta, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool hasPending = receta.pendingMedications > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.medication_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'N.º ${receta.id}',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Fecha',
              value: receta.creationDate,
            ),

            const SizedBox(height: 8),

            _InfoRow(
              icon: Icons.person_outline,
              label: 'Profesional',
              value: receta.professional,
            ),

            const SizedBox(height: 8),

            _InfoRow(
              icon: Icons.location_on_outlined,
              label: 'Local',
              value: receta.location,
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: hasPending
                    ? Colors.orange.withValues(alpha: 0.08)
                    : Colors.green.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    hasPending
                        ? Icons.pending_actions_outlined
                        : Icons.check_circle_outline,
                    color: hasPending
                        ? Colors.orange.shade800
                        : Colors.green.shade700,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${receta.deliveredMedications} de '
                      '${receta.totalMedications} medicamentos '
                      'completamente entregados',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: hasPending
                            ? Colors.orange.shade900
                            : Colors.green.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Ver detalle'),
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
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
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
