import 'package:flutter/material.dart';

import 'package:portal_paciente/models/exam.dart';
import 'pdf_viewer_screen.dart';
import '../widgets/portal_card.dart';

class LaboratoryScreen extends StatelessWidget {
  const LaboratoryScreen({super.key});

  final List<Exam> examenes = const [
    Exam(
      id: '496623',
      requestingDoctor: 'Profesional solicitante',
      service: 'Traslado',
      attention: 'No informada',
      date: '21-07-2026',
      resultAvailable: true,
      pdfPath: 'assets/pdf/resultado_laboratorio_prueba.pdf',
    ),
    Exam(
      id: '496563',
      requestingDoctor: 'Profesional solicitante',
      service: 'Traslado',
      attention: 'No informada',
      date: '20-07-2026',
      resultAvailable: true,
      pdfPath: 'assets/pdf/resultado_laboratorio_prueba.pdf',
    ),
    Exam(
      id: '354107',
      requestingDoctor: 'Profesional solicitante',
      service: 'Gastroenterología',
      attention: 'No informada',
      date: '10-12-2025',
      resultAvailable: true,
      pdfPath: 'assets/pdf/resultado_laboratorio_prueba.pdf',
    ),
    Exam(
      id: '354065',
      requestingDoctor: 'Profesional solicitante',
      service: 'Gastroenterología',
      attention: 'No informada',
      date: '10-12-2025',
      resultAvailable: true,
      pdfPath: 'assets/pdf/resultado_laboratorio_prueba.pdf',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laboratorio')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: examenes.length,
        itemBuilder: (context, index) {
          final examen = examenes[index];

          return _LaboratoryCard(
            numero: examen.id,
            fecha: examen.date,
            medico: examen.requestingDoctor,
            servicio: examen.service,
            atencion: examen.attention,
            onTap: () {
              if (examen.pdfPath == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El resultado aún no está disponible.'),
                  ),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PdfViewerScreen(pdfPath: examen.pdfPath!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _LaboratoryCard extends StatelessWidget {
  final String numero;
  final String fecha;
  final String medico;
  final String servicio;
  final String atencion;
  final VoidCallback onTap;

  const _LaboratoryCard({
    required this.numero,
    required this.fecha,
    required this.medico,
    required this.servicio,
    required this.atencion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PortalCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.science_outlined,
                  size: 28,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'Examen de laboratorio',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _InfoRow(label: 'N.º de examen', value: numero),
          _InfoRow(label: 'Fecha', value: fecha),
          _InfoRow(label: 'Médico solicitante', value: medico),
          _InfoRow(label: 'Servicio', value: servicio),
          _InfoRow(label: 'Atención', value: atencion),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text('Ver resultado'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
