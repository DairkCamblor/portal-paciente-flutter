import 'package:flutter/material.dart';

import 'package:portal_paciente/models/exam.dart';
import 'pdf_viewer_screen.dart';
import '../theme/app_spacing.dart';
import '../widgets/icon_tile.dart';
import '../widgets/info_row.dart';
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
        padding: AppSpacing.screenPadding,
        itemCount: examenes.length,
        itemBuilder: (context, index) {
          final examen = examenes[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: _LaboratoryCard(
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
            ),
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
    return PortalCard(
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconTile(Icons.science_outlined, size: 52),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Examen de laboratorio',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          const Divider(),

          const SizedBox(height: AppSpacing.md),

          InfoRow(
            icon: Icons.numbers_outlined,
            label: 'N.º de examen',
            value: numero,
          ),
          InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Fecha',
            value: fecha,
          ),
          InfoRow(
            icon: Icons.person_outline,
            label: 'Médico solicitante',
            value: medico,
          ),
          InfoRow(
            icon: Icons.medical_services_outlined,
            label: 'Servicio',
            value: servicio,
          ),
          InfoRow(
            icon: Icons.assignment_outlined,
            label: 'Atención',
            value: atencion,
          ),

          const SizedBox(height: AppSpacing.xs),

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
