import 'package:flutter/material.dart';

import 'package:portal_paciente/models/notification.dart';

import 'appointments_screen.dart';
import 'laboratory_screen.dart';
import 'prescriptions_screen.dart';
import '../widgets/portal_card.dart';

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
    final unreadCount = notifications
        .where((notification) => !notification.read)
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (unreadCount > 0) ...[
            PortalCard(
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.notifications_active_outlined,
                      size: 28,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$unreadCount '
                          '${unreadCount == 1 ? 'notificación nueva' : 'notificaciones nuevas'}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tienes información nueva para revisar.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          const Text(
            'Tus notificaciones',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          ...notifications.map(
            (notification) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _NotificationCard(
                notification: notification,
                onTap: () {
                  _openNotification(context, notification);
                },
              ),
            ),
          ),

          const SizedBox(height: 8),
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
    final colorScheme = Theme.of(context).colorScheme;

    return PortalCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: notification.read
                  ? colorScheme.surfaceContainerHighest
                  : colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _getIcon(),
              size: 28,
              color: notification.read
                  ? colorScheme.onSurfaceVariant
                  : colorScheme.primary,
            ),
          ),

          const SizedBox(width: 14),

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
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: notification.read
                              ? FontWeight.w600
                              : FontWeight.bold,
                        ),
                      ),
                    ),

                    if (!notification.read) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  notification.date,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
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
