import 'package:flutter/material.dart';
import 'package:portal_paciente/models/appointment.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/icon_tile.dart';
import '../widgets/info_row.dart';
import '../widgets/portal_card.dart';
import '../widgets/section_header.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final List<Appointment> horas = [
    const Appointment(
      specialty: 'Medicina General',
      doctor: 'Dr. García',
      date: '10 de septiembre',
      time: '09:30',
      location: 'Hospital Regional',
    ),
    const Appointment(
      specialty: 'Odontología',
      doctor: 'Dra. Martínez',
      date: '18 de septiembre',
      time: '15:00',
      location: 'Centro de Especialidades',
    ),
    const Appointment(
      specialty: 'Cardiología',
      doctor: 'Dr. López',
      date: '25 de septiembre',
      time: '11:00',
      location: 'Hospital Regional',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis horas')),

      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          const SectionHeader('Próximas atenciones'),

          for (final hora in horas)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _AppointmentCard(
                specialty: hora.specialty,
                doctor: hora.doctor,
                date: hora.date,
                time: hora.time,
                location: hora.location,
                icon: Icons.medical_services_outlined,
              ),
            ),

          const SizedBox(height: AppSpacing.md),

          const SectionHeader('Historial'),

          const _HistoryItem(
            specialty: 'Medicina General',
            date: '02 de agosto de 2026',
          ),

          const _HistoryItem(
            specialty: 'Laboratorio',
            date: '15 de julio de 2026',
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String specialty;
  final String doctor;
  final String date;
  final String time;
  final String location;
  final IconData icon;

  const _AppointmentCard({
    required this.specialty,
    required this.doctor,
    required this.date,
    required this.time,
    required this.location,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return PortalCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconTile(icon, size: 52),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  specialty,
                  style: Theme.of(context).textTheme.titleSmall,
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
            value: doctor,
          ),

          InfoRow(
            icon: Icons.event_outlined,
            label: 'Fecha y hora',
            value: '$date · $time',
          ),

          InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Lugar',
            value: location,
          ),

          const SizedBox(height: AppSpacing.xs),

          OutlinedButton(onPressed: () {}, child: const Text('Ver detalles')),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String specialty;
  final String date;

  const _HistoryItem({required this.specialty, required this.date});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.check_circle_outline, color: AppColors.success),
      title: Text(
        specialty,
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(date, style: textTheme.bodySmall),
    );
  }
}
