import 'package:flutter/material.dart';

import '../widgets/portal_card.dart';

class AuthorizationsScreen extends StatelessWidget {
  const AuthorizationsScreen({super.key});

  // Datos ficticios para el prototipo.
  // Más adelante estos documentos vendrán desde la API
  // y el sistema institucional de autorizaciones.

  final List<AuthorizationDocument> documentosPendientes = const [
    AuthorizationDocument(
      id: 'auth_001',
      title: 'Consentimiento informado',
      description: 'Documento asociado a una atención de salud.',
      date: '08-09-2026',
      status: 'Pendiente',
    ),
  ];

  final List<AuthorizationDocument> documentosFirmados = const [
    AuthorizationDocument(
      id: 'auth_002',
      title: 'Consentimiento informado',
      description: 'Documento asociado a un procedimiento realizado.',
      date: '25-08-2026',
      status: 'Firmado',
    ),
    AuthorizationDocument(
      id: 'auth_003',
      title: 'Autorización de procedimiento',
      description: 'Documento asociado a una atención de salud.',
      date: '12-06-2026',
      status: 'Firmado',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autorizaciones – Firmas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Mis documentos',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Revisa los documentos asociados a tus atenciones de salud.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 24),

          // ─────────────────────────────────────
          // DOCUMENTOS PENDIENTES
          // ─────────────────────────────────────
          if (documentosPendientes.isNotEmpty) ...[
            const _SectionTitle(
              icon: Icons.pending_actions_outlined,
              title: 'Documentos pendientes',
            ),

            const SizedBox(height: 12),

            ...documentosPendientes.map(
              (documento) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _PendingDocumentCard(
                  document: documento,
                  onTap: () {
                    _showDocumentDetails(context, documento);
                  },
                ),
              ),
            ),
          ],

          // ─────────────────────────────────────
          // DOCUMENTOS FIRMADOS
          // ─────────────────────────────────────
          if (documentosFirmados.isNotEmpty) ...[
            const SizedBox(height: 8),

            const _SectionTitle(
              icon: Icons.check_circle_outline,
              title: 'Documentos firmados',
            ),

            const SizedBox(height: 12),

            ...documentosFirmados.map(
              (documento) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SignedDocumentCard(
                  document: documento,
                  onTap: () {
                    _showDocumentDetails(context, documento);
                  },
                ),
              ),
            ),
          ],

          const SizedBox(height: 12),

          Text(
            'La disponibilidad y estado de los documentos dependerá de la información registrada en los sistemas institucionales.',
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

  void _showDocumentDetails(
    BuildContext context,
    AuthorizationDocument document,
  ) {
    final bool firmado = document.status == 'Firmado';

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
                        Icons.description_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        document.title,
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
                  value: document.status,
                ),

                _DetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Fecha',
                  value: document.date,
                ),

                _DetailRow(
                  icon: Icons.description_outlined,
                  label: 'Descripción',
                  value: document.description,
                ),

                const SizedBox(height: 4),

                if (firmado)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Visualización del documento próximamente.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.visibility_outlined),
                      label: const Text('Ver documento'),
                    ),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Proceso de autorización próximamente.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Continuar'),
                    ),
                  ),

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
// MODELO
// ─────────────────────────────────────────────

class AuthorizationDocument {
  final String id;
  final String title;
  final String description;
  final String date;
  final String status;

  const AuthorizationDocument({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });
}

// ─────────────────────────────────────────────
// TÍTULO DE SECCIÓN
// ─────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

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
// DOCUMENTO PENDIENTE
// ─────────────────────────────────────────────

class _PendingDocumentCard extends StatelessWidget {
  final AuthorizationDocument document;
  final VoidCallback onTap;

  const _PendingDocumentCard({required this.document, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                  color: Colors.orange.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.pending_actions_outlined,
                  size: 28,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Requiere revisión',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              _StatusBadge(status: document.status),
            ],
          ),

          const SizedBox(height: 16),

          Divider(color: colorScheme.outlineVariant),

          const SizedBox(height: 12),

          Text(
            document.description,
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
          ),

          const SizedBox(height: 8),

          Text('Fecha: ${document.date}', style: const TextStyle(fontSize: 14)),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Revisar'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DOCUMENTO FIRMADO
// ─────────────────────────────────────────────

class _SignedDocumentCard extends StatelessWidget {
  final AuthorizationDocument document;
  final VoidCallback onTap;

  const _SignedDocumentCard({required this.document, required this.onTap});

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
                Text(
                  document.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Firmado · ${document.date}',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
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

  @override
  Widget build(BuildContext context) {
    final bool pendiente = status == 'Pendiente';

    final color = pendiente ? Colors.orange : Colors.green;

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

// ─────────────────────────────────────────────
// DETALLE
// ─────────────────────────────────────────────

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
          Icon(icon, size: 21, color: colorScheme.primary),
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
