import 'package:flutter/material.dart';

import 'package:portal_paciente/screens/first_attention_screen.dart';
import 'package:portal_paciente/screens/procedures_screen.dart';
import 'package:portal_paciente/screens/kinesiology_screen.dart';
import '../widgets/portal_card.dart';

class ReferralsScreen extends StatelessWidget {
  const ReferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Derivaciones')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Mis derivaciones',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Consulta el estado de tus derivaciones y solicitudes de atención.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),

          _ReferralCategoryCard(
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

          const SizedBox(height: 16),

          _ReferralCategoryCard(
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

          const SizedBox(height: 16),

          _ReferralCategoryCard(
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

class _ReferralCategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ReferralCategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PortalCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 30, color: colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 28,
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
