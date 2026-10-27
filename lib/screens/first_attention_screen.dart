import 'package:flutter/material.dart';

import 'package:portal_paciente/models/referral.dart';
import '../theme/app_spacing.dart';
import '../widgets/detail_sheet.dart';
import '../widgets/info_row.dart';
import '../widgets/referral_card.dart';

class FirstAttentionScreen extends StatelessWidget {
  const FirstAttentionScreen({super.key});

  final List<Referral> derivaciones = const [
    Referral(
      id: 'ref_001',
      type: 'Primera atención',
      name: 'Cardiología',
      status: 'Agendado',
      requestDate: '12-06-2026',
      appointmentDate: '25-09-2026',
      appointmentTime: '11:00',
      location: 'Hospital Regional',
    ),
    Referral(
      id: 'ref_002',
      type: 'Primera atención',
      name: 'Traumatología',
      status: 'Pendiente',
      requestDate: '20-07-2026',
      appointmentDate: null,
      appointmentTime: null,
      location: null,
    ),
    Referral(
      id: 'ref_003',
      type: 'Primera atención',
      name: 'Gastroenterología',
      status: 'Egresada',
      requestDate: '05-03-2026',
      appointmentDate: '18-04-2026',
      appointmentTime: '09:30',
      location: 'Hospital Regional',
    ),
    Referral(
      id: 'ref_004',
      type: 'Primera atención',
      name: 'Neurología',
      status: 'Egresada - En control',
      requestDate: '15-02-2026',
      appointmentDate: '30-03-2026',
      appointmentTime: '14:00',
      location: 'Centro de Especialidades',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Primera atención')),
      body: ListView.builder(
        padding: AppSpacing.screenPadding,
        itemCount: derivaciones.length,
        itemBuilder: (context, index) {
          final derivacion = derivaciones[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: ReferralCard(
              referral: derivacion,
              icon: Icons.medical_services_outlined,
              subtitle: derivacion.type,
              unscheduledLabel: 'Aún no agendada',
              missingLocationLabel: 'Aún no asignado',
              onTap: () {
                _showDetails(context, derivacion);
              },
            ),
          );
        },
      ),
    );
  }

  void _showDetails(BuildContext context, Referral referral) {
    showDetailSheet(
      context,
      title: referral.name,
      icon: Icons.medical_services_outlined,
      children: [
        InfoRow(
          icon: Icons.info_outline,
          label: 'Estado',
          value: referral.status,
        ),

        InfoRow(
          icon: Icons.calendar_today_outlined,
          label: 'Fecha de solicitud',
          value: referral.requestDate,
        ),

        InfoRow(
          icon: Icons.event_outlined,
          label: 'Fecha de atención',
          value: referral.appointmentDate ?? 'Aún no agendada',
        ),

        if (referral.appointmentTime != null)
          InfoRow(
            icon: Icons.access_time,
            label: 'Hora',
            value: referral.appointmentTime!,
          ),

        if (referral.location != null)
          InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Lugar',
            value: referral.location!,
          ),
      ],
    );
  }
}
