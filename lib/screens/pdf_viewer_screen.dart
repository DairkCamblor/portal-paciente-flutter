import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PdfViewerScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado del examen')),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}
