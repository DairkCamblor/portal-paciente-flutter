class AppNotification {
  final String id;
  final String title;
  final String message;
  final String date;
  final NotificationType type;
  final bool read;
  final String? relatedId;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.type,
    required this.read,
    this.relatedId,
  });
}

enum NotificationType {
  appointment,
  prescription,
  medication,
  exam,
  interconsultation,
  authorization,
  general,
}
