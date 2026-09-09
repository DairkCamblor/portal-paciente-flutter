import 'package:flutter/material.dart';

import '../widgets/portal_card.dart';

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
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Kinesiología',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Consulta tus tratamientos y sesiones de rehabilitación.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),

          // ─────────────────────────────────────
          // TRATAMIENTOS ACTUALES
          // ─────────────────────────────────────
          const SizedBox(height: 24),

          const _SectionTitle(
            title: 'Tratamientos actuales',
            icon: Icons.accessibility_new_outlined,
          ),

          const SizedBox(height: 12),

          ...tratamientosActuales.map(
            (tratamiento) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
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
          const SizedBox(height: 8),

          const _SectionTitle(
            title: 'Tratamientos finalizados',
            icon: Icons.check_circle_outline,
          ),

          const SizedBox(height: 12),

          ...tratamientosFinalizados.map(
            (tratamiento) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CompletedTreatmentCard(
                treatment: tratamiento,
                onTap: () {
                  _showDetails(context, tratamiento);
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'La información mostrada corresponde a datos registrados en los sistemas institucionales.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, KinesiologyTreatment treatment) {
    final bool egresado = treatment.estado == 'Egresado';

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
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.directions_run_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Kinesiología',
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                _InfoRow(
                  icon: Icons.info_outline,
                  label: 'Estado',
                  value: treatment.estado,
                ),

                _InfoRow(
                  icon: Icons.medical_services_outlined,
                  label: 'Especialidad de origen',
                  value: treatment.especialidadOrigen,
                ),

                _InfoRow(
                  icon: Icons.accessibility_new_outlined,
                  label: 'Tipo de procedimiento',
                  value: treatment.tipoProcedimiento,
                ),

                const SizedBox(height: 2),

                _InfoRow(
                  icon: Icons.confirmation_number_outlined,
                  label: 'Sesiones',
                  value:
                      '${treatment.sesionesRealizadas} de ${treatment.sesionesTotales} realizadas',
                ),

                if (!egresado && treatment.proximaSesion != null) ...[
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Próxima sesión',
                    value: treatment.proximaSesion!,
                  ),
                  _InfoRow(
                    icon: Icons.access_time,
                    label: 'Hora',
                    value: treatment.horaProximaSesion ?? '',
                  ),
                ],

                if (!egresado && treatment.lugar != null)
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Lugar',
                    value: treatment.lugar!,
                  ),

                if (egresado) ...[
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Tratamiento finalizado.',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 8),

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
// TÍTULO DE SECCIÓN
// ─────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 22, color: colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
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
    final colorScheme = Theme.of(context).colorScheme;

    final double progreso = treatment.sesionesTotales == 0
        ? 0
        : treatment.sesionesRealizadas / treatment.sesionesTotales;

    final int pendientes =
        treatment.sesionesTotales - treatment.sesionesRealizadas;

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
                  Icons.directions_run_outlined,
                  size: 28,
                  color: colorScheme.primary,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kinesiología',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      treatment.especialidadOrigen,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              _StatusBadge(status: treatment.estado),
            ],
          ),

          const SizedBox(height: 18),

          Divider(color: colorScheme.outlineVariant),

          const SizedBox(height: 14),

          _InfoRow(
            icon: Icons.accessibility_new_outlined,
            label: 'Tipo de procedimiento',
            value: treatment.tipoProcedimiento,
          ),

          const SizedBox(height: 2),

          const Text(
            'Sesiones',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 6),

          Text(
            '${treatment.sesionesRealizadas} de ${treatment.sesionesTotales} realizadas',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(value: progreso, minHeight: 9),
          ),

          const SizedBox(height: 8),

          Text(
            '$pendientes sesiones pendientes',
            style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
          ),

          if (treatment.proximaSesion != null) ...[
            const SizedBox(height: 14),

            _InfoRow(
              icon: Icons.event_outlined,
              label: 'Próxima sesión',
              value:
                  '${treatment.proximaSesion} • ${treatment.horaProximaSesion}',
            ),
          ],

          if (treatment.lugar != null)
            _InfoRow(
              icon: Icons.location_on_outlined,
              label: 'Lugar',
              value: treatment.lugar!,
            ),

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

// ─────────────────────────────────────────────
// TARJETA TRATAMIENTO FINALIZADO
// ─────────────────────────────────────────────

class _CompletedTreatmentCard extends StatelessWidget {
  final KinesiologyTreatment treatment;
  final VoidCallback onTap;

  const _CompletedTreatmentCard({required this.treatment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PortalCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 27,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kinesiología',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 3),

                Text(
                  treatment.especialidadOrigen,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '${treatment.sesionesRealizadas} de ${treatment.sesionesTotales} sesiones realizadas',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          _StatusBadge(status: treatment.estado),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FILA DE INFORMACIÓN
// ─────────────────────────────────────────────

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
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),

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
                    fontSize: 15,
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

// ─────────────────────────────────────────────
// ESTADO
// ─────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  Color get _statusColor {
    switch (status) {
      case 'Pendiente':
        return Colors.orange;

      case 'En tratamiento':
        return Colors.blue;

      case 'Egresado':
        return Colors.green;

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
