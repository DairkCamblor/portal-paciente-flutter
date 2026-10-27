import 'package:flutter/material.dart';

import '../models/referral.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'icon_tile.dart';
import 'portal_card.dart';
import 'status_badge.dart';

/// Tarjeta de una derivación (primera atención o procedimiento).
///
/// Si la derivación está "Agendado" destaca fecha y hora; en otro caso muestra
/// [unscheduledLabel]. Muestra además la fecha de solicitud y el lugar.
class ReferralCard extends StatelessWidget {
  final Referral referral;
  final IconData icon;
  final String subtitle;
  final String unscheduledLabel;
  final String missingLocationLabel;
  final VoidCallback onTap;

  const ReferralCard({
    super.key,
    required this.referral,
    required this.icon,
    required this.subtitle,
    required this.unscheduledLabel,
    required this.missingLocationLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool agendado = referral.status == 'Agendado';

    return PortalCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconTile(icon, size: 52),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(referral.name, style: textTheme.titleSmall),
                    const SizedBox(height: AppSpacing.xs),
                    Text(subtitle, style: textTheme.bodySmall),
                    const SizedBox(height: AppSpacing.sm),
                    StatusBadge(referral.status),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          const Divider(),

          const SizedBox(height: AppSpacing.md),

          if (agendado) ...[
            Text('Fecha de atención', style: textTheme.labelMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${referral.appointmentDate} • ${referral.appointmentTime}',
              style: textTheme.titleSmall?.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ] else
            _MetaLine(icon: Icons.event_busy_outlined, text: unscheduledLabel),

          const SizedBox(height: AppSpacing.md),

          _MetaLine(
            icon: Icons.calendar_today_outlined,
            text: 'Solicitud: ${referral.requestDate}',
          ),

          const SizedBox(height: AppSpacing.sm),

          _MetaLine(
            icon: Icons.location_on_outlined,
            text: referral.location ?? missingLocationLabel,
          ),

          const SizedBox(height: AppSpacing.sm),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward),
              iconAlignment: IconAlignment.end,
              label: const Text('Ver detalle'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.textScalerOf(context).scale(20);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(
          child: Icon(icon, size: iconSize, color: AppColors.textSecondary),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
