import 'package:flutter/material.dart';
import 'laboratory_screen.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Exámenes')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mis Exámenes',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            const Text(
              'Consulta tus exámenes y resultados.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: _ExamCategoryCard(
                    icon: Icons.science_outlined,
                    title: 'Laboratorio',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LaboratoryScreen(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _ExamCategoryCard(
                    icon: Icons.medical_services_outlined,
                    title: 'Imagenología',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExamCategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ExamCategoryCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 48),

              const SizedBox(height: 16),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
