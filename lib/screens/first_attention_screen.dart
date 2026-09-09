import 'package:flutter/material.dart';

import 'package:portal_paciente/models/referral.dart';
import '../widgets/portal_card.dart';

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
        padding: const EdgeInsets.all(20),
        itemCount: derivaciones.length,
        itemBuilder: (context, index) {
          final derivacion = derivaciones[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ReferralCard(
              referral: derivacion,
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                referral.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              _DetailRow(
                icon: Icons.info_outline,
                label: 'Estado',
                value: referral.status,
              ),

              _DetailRow(
                icon: Icons.calendar_today_outlined,
                label: 'Fecha de solicitud',
                value: referral.requestDate,
              ),

              _DetailRow(
                icon: Icons.event_outlined,
                label: 'Fecha de atención',
                value: referral.appointmentDate ?? 'Aún no agendada',
              ),

              if (referral.appointmentTime != null)
                _DetailRow(
                  icon: Icons.access_time,
                  label: 'Hora',
                  value: referral.appointmentTime!,
                ),

              if (referral.location != null)
                _DetailRow(
                  icon: Icons.location_on_outlined,
                  label: 'Lugar',
                  value: referral.location!,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ReferralCard extends StatelessWidget {
  final Referral referral;
  final VoidCallback onTap;

  const _ReferralCard({required this.referral, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool agendado = referral.status == 'Agendado';

    return PortalCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ENCABEZADO
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  size: 28,
                  color: colorScheme.primary,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      referral.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      referral.type,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              _StatusBadge(status: referral.status),
            ],
          ),

          const SizedBox(height: 18),

          const Divider(),

          const SizedBox(height: 12),

          // FECHA DE ATENCIÓN
          if (agendado) ...[
            Text(
              'Fecha de atención',
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              '${referral.appointmentDate} • '
              '${referral.appointmentTime}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),
          ] else ...[
            Row(
              children: [
                Icon(
                  Icons.event_busy_outlined,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'Aún no agendada',
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
          ],

          // FECHA DE SOLICITUD
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Solicitud: ${referral.requestDate}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // LUGAR
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  referral.location ?? 'Aún no asignado',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Ver detalle'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context) {
    switch (status) {
      case 'Agendado':
        return Colors.green;

      case 'Pendiente':
        return Colors.orange;

      case 'Egresada':
        return Colors.grey;

      case 'Egresada - En control':
        return Colors.blue;

      default:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: colorScheme.primary),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
