class Referral {
  final String id;
  final String type;
  final String name;
  final String status;
  final String requestDate;
  final String? appointmentDate;
  final String? appointmentTime;
  final String? location;

  const Referral({
    required this.id,
    required this.type,
    required this.name,
    required this.status,
    required this.requestDate,
    this.appointmentDate,
    this.appointmentTime,
    this.location,
  });
}
