import 'package:flutter/material.dart';
import 'package:portal_paciente/models/notification.dart';

import 'appointments_screen.dart';
import 'laboratory_screen.dart';
import 'prescriptions_screen.dart';

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
      body: Column(
        children: [
          if (unreadCount > 0)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active_outlined,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tienes $unreadCount '
                      '${unreadCount == 1 ? 'notificación nueva' : 'notificaciones nuevas'}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];

                return _NotificationCard(
                  notification: notification,
                  onTap: () {
                    _openNotification(context, notification);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openNotification(BuildContext context, AppNotification notification) {
    switch (notification.type) {
      case NotificationType.appointment:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AppointmentsScreen()),
        );
        break;

      case NotificationType.medication:
      case NotificationType.prescription:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrescriptionsScreen()),
        );
        break;

      case NotificationType.exam:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LaboratoryScreen()),
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
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: notification.read ? 1 : 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _getIcon(),
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
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

                        if (!notification.read)
                          Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(left: 8, top: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Text(
                      notification.message,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: Colors.grey.shade800,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      notification.date,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
