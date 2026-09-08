class Exam {
  final String id;
  final String requestingDoctor;
  final String service;
  final String attention;
  final String date;
  final bool resultAvailable;
  final String? pdfPath;

  const Exam({
    required this.id,
    required this.requestingDoctor,
    required this.service,
    required this.attention,
    required this.date,
    required this.resultAvailable,
    this.pdfPath,
  });
}
