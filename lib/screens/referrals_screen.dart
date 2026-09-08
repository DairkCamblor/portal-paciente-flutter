import 'package:flutter/material.dart';
import 'package:portal_paciente/screens/first_attention_screen.dart';
import 'package:portal_paciente/screens/procedures_screen.dart';

class ReferralsScreen extends StatelessWidget {
  const ReferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Derivaciones')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Consulta el estado de tus derivaciones y solicitudes de atención.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),

          const SizedBox(height: 24),

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
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
