import 'package:flutter/material.dart';

import 'package:portal_paciente/models/referral.dart';
import '../widgets/portal_card.dart';

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
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Tus procedimientos',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Consulta el estado y los detalles de tus procedimientos.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),

          ...procedimientos.map(
            (procedimiento) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ProcedureCard(
                referral: procedimiento,
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.biotech_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        referral.name,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

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

                const SizedBox(height: 4),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cerrar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProcedureCard extends StatelessWidget {
  final Referral referral;
  final VoidCallback onTap;

  const _ProcedureCard({required this.referral, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool agendado = referral.status == 'Agendado';

    return PortalCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  Icons.biotech_outlined,
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
                      'Procedimiento',
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

          Divider(color: colorScheme.outlineVariant),

          const SizedBox(height: 14),

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
              '${referral.appointmentDate} • ${referral.appointmentTime}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
          ] else ...[
            Row(
              children: [
                Icon(
                  Icons.schedule_outlined,
                  size: 19,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'Aún no agendado',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],

          _InfoRow(
            icon: Icons.calendar_today_outlined,
            text: 'Solicitud: ${referral.requestDate}',
          ),

          const SizedBox(height: 8),

          _InfoRow(
            icon: Icons.location_on_outlined,
            text: referral.location ?? 'Lugar aún no asignado',
          ),

          const SizedBox(height: 12),

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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  Color get _statusColor {
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
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
