class Prescription {
  final String id;
  final String professional;
  final String professionalRun;
  final String location;
  final String requestDate;
  final String creationDate;
  final List<PrescriptionMedication> medications;

  const Prescription({
    required this.id,
    required this.professional,
    required this.professionalRun,
    required this.location,
    required this.requestDate,
    required this.creationDate,
    required this.medications,
  });

  int get totalMedications => medications.length;

  int get deliveredMedications =>
      medications.where((medication) => medication.fullyDelivered).length;

  int get pendingMedications =>
      medications.where((medication) => !medication.fullyDelivered).length;
}

class PrescriptionMedication {
  final String name;
  final String quantity;
  final String dose;
  final String unit;
  final String frequency;
  final String period;
  final String administrationRoute;
  final String observation;

  final int deliveries;
  final int totalDeliveries;

  const PrescriptionMedication({
    required this.name,
    required this.quantity,
    required this.dose,
    required this.unit,
    required this.frequency,
    required this.period,
    required this.administrationRoute,
    required this.observation,
    required this.deliveries,
    required this.totalDeliveries,
  });

  bool get fullyDelivered => deliveries >= totalDeliveries;
}
