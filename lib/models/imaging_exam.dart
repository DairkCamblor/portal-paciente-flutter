class ImagingExam {
  final String id;
  final String study;
  final String requestingDoctor;
  final String service;
  final String attention;
  final String date;
  final bool reportAvailable;
  final bool imagesAvailable;
  final bool pacsAvailable;
  final String? reportPdfPath;

  const ImagingExam({
    required this.id,
    required this.study,
    required this.requestingDoctor,
    required this.service,
    required this.attention,
    required this.date,
    required this.reportAvailable,
    required this.imagesAvailable,
    required this.pacsAvailable,
    this.reportPdfPath,
  });
}
