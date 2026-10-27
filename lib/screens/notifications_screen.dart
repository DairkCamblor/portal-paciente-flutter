import 'package:flutter/material.dart';

import 'package:portal_paciente/models/notification.dart';

import 'appointments_screen.dart';
import 'laboratory_screen.dart';
import 'prescriptions_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/icon_tile.dart';
import '../widgets/portal_card.dart';
import '../widgets/section_header.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<AppNotification> notifications = const [
    AppNotification(
      id: '1',
      title: 'Medicamento pendiente',
      message:
          'Tienes un medicamento pendiente de entrega en tu receta médica.',
      date: 'Hoy, 10:32',
      type: NotificationType.medication,
      read: false,
      relatedId: '886724',
    ),
    AppNotification(
      id: '2',
      title: 'Cambio de hora médica',
      message:
          'Tu hora de Medicina General fue modificada. Revisa los nuevos datos.',
      date: 'Ayer, 16:45',
      type: NotificationType.appointment,
      read: false,
      relatedId: 'appointment_001',
    ),
    AppNotification(
      id: '3',
      title: 'Nuevo resultado disponible',
      message: 'Ya puedes consultar el resultado de tu examen de laboratorio.',
      date: '05-09-2026',
      type: NotificationType.exam,
      read: false,
      relatedId: '496623',
    ),
    AppNotification(
      id: '4',
      title: 'Nueva receta médica',
      message: 'Se ha generado una nueva receta después de tu atención médica.',
      date: '04-09-2026',
      type: NotificationType.prescription,
      read: true,
      relatedId: '886724',
    ),
    AppNotification(
      id: '5',
      title: 'Recordatorio de atención',
      message:
          'Recuerda que tienes una atención médica programada próximamente.',
      date: '03-09-2026',
      type: NotificationType.appointment,
      read: true,
      relatedId: 'appointment_002',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final unreadCount = notifications
        .where((notification) => !notification.read)
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          if (unreadCount > 0) ...[
            PortalCard(
              margin: EdgeInsets.zero,
              child: Row(
                children: [
                  const IconTile(Icons.notifications_active_outlined, size: 52),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$unreadCount '
                          '${unreadCount == 1 ? 'notificación nueva' : 'notificaciones nuevas'}',
                          style: textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Tienes información nueva para revisar.',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          const SectionHeader('Tus notificaciones'),

          ...notifications.map(
            (notification) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _NotificationCard(
                notification: notification,
                onTap: () {
                  _openNotification(context, notification);
                },
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }

  void _openNotification(BuildContext context, AppNotification notification) {
    switch (notification.type) {
      case NotificationType.appointment:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
        );
        break;

      case NotificationType.medication:
      case NotificationType.prescription:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PrescriptionsScreen()),
        );
        break;

      case NotificationType.exam:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LaboratoryScreen()),
        );
        break;

      case NotificationType.interconsultation:
      case NotificationType.authorization:
      case NotificationType.general:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(notification.message)));
        break;
    }
  }
}

class _NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const _NotificationCard({required this.notification, required this.onTap});

  IconData _getIcon() {
    switch (notification.type) {
      case NotificationType.appointment:
        return Icons.calendar_month_outlined;

      case NotificationType.exam:
        return Icons.science_outlined;

      case NotificationType.prescription:
        return Icons.receipt_long_outlined;

      case NotificationType.medication:
        return Icons.medication_outlined;

      case NotificationType.interconsultation:
        return Icons.assignment_outlined;

      case NotificationType.authorization:
        return Icons.verified_user_outlined;

      case NotificationType.general:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool unread = !notification.read;

    return PortalCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTile(
            _getIcon(),
            size: 52,
            color: unread ? AppColors.primary : AppColors.textSecondary,
            backgroundColor: unread
                ? AppColors.primarySoft
                : AppColors.surfaceMuted,
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: unread
                              ? FontWeight.w700
                              : FontWeight.w600,
                        ),
                      ),
                    ),

                    if (unread) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Semantics(
                        label: 'No leída',
                        child: Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(top: 6),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: AppSpacing.sm),

                Text(notification.message, style: textTheme.bodyMedium),

                const SizedBox(height: AppSpacing.sm),

                Text(notification.date, style: textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
