import 'package:flutter/material.dart';

import 'package:portal_paciente/models/referral.dart';
import '../theme/app_spacing.dart';
import '../widgets/detail_sheet.dart';
import '../widgets/info_row.dart';
import '../widgets/referral_card.dart';
import '../widgets/screen_header.dart';

class ProceduresScreen extends StatelessWidget {
  const ProceduresScreen({super.key});

  final List<Referral> procedimientos = const [
    Referral(
      id: 'proc_001',
      type: 'Procedimiento',
      name: 'Resonancia magnética',
      status: 'Agendado',
      requestDate: '10-06-2026',
      appointmentDate: '28-09-2026',
      appointmentTime: '10:30',
      location: 'Hospital Regional',
    ),
    Referral(
      id: 'proc_002',
      type: 'Procedimiento',
      name: 'Crioterapia',
      status: 'Pendiente',
      requestDate: '18-07-2026',
      appointmentDate: null,
      appointmentTime: null,
      location: null,
    ),
    Referral(
      id: 'proc_003',
      type: 'Procedimiento',
      name: 'Ecografía abdominal',
      status: 'Agendado',
      requestDate: '02-07-2026',
      appointmentDate: '03-10-2026',
      appointmentTime: '08:45',
      location: 'Centro de Especialidades',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Procedimientos')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          const ScreenHeader.intro(
            'Consulta el estado y los detalles de tus procedimientos.',
          ),

          ...procedimientos.map(
            (procedimiento) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: ReferralCard(
                referral: procedimiento,
                icon: Icons.biotech_outlined,
                subtitle: 'Procedimiento',
                unscheduledLabel: 'Aún no agendado',
                missingLocationLabel: 'Lugar aún no asignado',
                onTap: () {
                  _showDetails(context, procedimiento);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, Referral referral) {
    showDetailSheet(
      context,
      title: referral.name,
      icon: Icons.biotech_outlined,
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
