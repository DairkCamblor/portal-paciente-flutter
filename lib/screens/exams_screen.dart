import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../widgets/category_card.dart';
import '../widgets/screen_header.dart';
import 'laboratory_screen.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Exámenes')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          const ScreenHeader.intro('Consulta tus exámenes y resultados.'),

          CategoryCard(
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

          const SizedBox(height: AppSpacing.lg),

          CategoryCard(
            icon: Icons.medical_services_outlined,
            title: 'Imagenología',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
