import 'package:flutter/material.dart';

import 'package:portal_paciente/screens/first_attention_screen.dart';
import 'package:portal_paciente/screens/procedures_screen.dart';
import 'package:portal_paciente/screens/kinesiology_screen.dart';
import '../theme/app_spacing.dart';
import '../widgets/category_card.dart';
import '../widgets/screen_header.dart';

class ReferralsScreen extends StatelessWidget {
  const ReferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Derivaciones')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          const ScreenHeader.intro(
            'Consulta el estado de tus derivaciones y solicitudes de atención.',
          ),

          CategoryCard(
            icon: Icons.medical_services_outlined,
            title: 'Primera atención',
            subtitle: 'Especialidades médicas',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FirstAttentionScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: AppSpacing.lg),

          CategoryCard(
            icon: Icons.biotech_outlined,
            title: 'Procedimientos',
            subtitle: 'Exámenes y procedimientos',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProceduresScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: AppSpacing.lg),

          CategoryCard(
            icon: Icons.directions_run_outlined,
            title: 'Kinesiología',
            subtitle: 'Sesiones de rehabilitación',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KinesiologyScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
