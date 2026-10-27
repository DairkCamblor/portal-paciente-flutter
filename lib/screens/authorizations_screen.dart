import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/detail_sheet.dart';
import '../widgets/icon_tile.dart';
import '../widgets/info_row.dart';
import '../widgets/portal_card.dart';
import '../widgets/screen_header.dart';
import '../widgets/section_header.dart';
import '../widgets/status_badge.dart';

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
        padding: AppSpacing.screenPadding,
        children: [
          const ScreenHeader(
            'Mis documentos',
            subtitle:
                'Revisa los documentos asociados a tus atenciones de salud.',
          ),

          // ─────────────────────────────────────
          // DOCUMENTOS PENDIENTES
          // ─────────────────────────────────────
          if (documentosPendientes.isNotEmpty) ...[
            const SectionHeader(
              'Documentos pendientes',
              icon: Icons.pending_actions_outlined,
            ),

            ...documentosPendientes.map(
              (documento) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
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
            const SizedBox(height: AppSpacing.sm),

            const SectionHeader(
              'Documentos firmados',
              icon: Icons.check_circle_outline,
            ),

            ...documentosFirmados.map(
              (documento) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _SignedDocumentCard(
                  document: documento,
                  onTap: () {
                    _showDocumentDetails(context, documento);
                  },
                ),
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.md),

          Text(
            'La disponibilidad y estado de los documentos dependerá de la información registrada en los sistemas institucionales.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
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

    showDetailSheet(
      context,
      title: document.title,
      icon: Icons.description_outlined,
      children: [
        InfoRow(
          icon: Icons.info_outline,
          label: 'Estado',
          value: document.status,
        ),

        InfoRow(
          icon: Icons.calendar_today_outlined,
          label: 'Fecha',
          value: document.date,
        ),

        InfoRow(
          icon: Icons.description_outlined,
          label: 'Descripción',
          value: document.description,
        ),
      ],
      actions: [
        if (firmado)
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Visualización del documento próximamente.'),
                ),
              );
            },
            icon: const Icon(Icons.visibility_outlined),
            label: const Text('Ver documento'),
          )
        else
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Proceso de autorización próximamente.'),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Continuar'),
          ),
      ],
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
// DOCUMENTO PENDIENTE
// ─────────────────────────────────────────────

class _PendingDocumentCard extends StatelessWidget {
  final AuthorizationDocument document;
  final VoidCallback onTap;

  const _PendingDocumentCard({required this.document, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PortalCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconTile(
                Icons.pending_actions_outlined,
                size: 52,
                color: AppColors.warningText,
                backgroundColor: AppColors.warningSoft,
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(document.title, style: textTheme.titleSmall),
                    const SizedBox(height: AppSpacing.xs),
                    Text('Requiere revisión', style: textTheme.bodySmall),
                    const SizedBox(height: AppSpacing.sm),
                    StatusBadge(document.status),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          const Divider(),

          const SizedBox(height: AppSpacing.md),

          Text(document.description, style: textTheme.bodyMedium),

          const SizedBox(height: AppSpacing.sm),

          Text('Fecha: ${document.date}', style: textTheme.bodySmall),

          const SizedBox(height: AppSpacing.md),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward),
              iconAlignment: IconAlignment.end,
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
    final textTheme = Theme.of(context).textTheme;

    return PortalCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Row(
        children: [
          const IconTile(
            Icons.check_circle_outline,
            size: 52,
            color: AppColors.successText,
            backgroundColor: AppColors.successSoft,
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(document.title, style: textTheme.titleSmall),

                const SizedBox(height: AppSpacing.xs),

                Text('Firmado · ${document.date}', style: textTheme.bodySmall),
              ],
            ),
          ),

          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
