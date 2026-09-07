import 'package:flutter/material.dart';
import 'package:portal_paciente/models/patient.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Patient patient = const Patient(
      name: 'Dairk Camblor',
      rut: '20.885.184-5',
      phone: '+56 9 1234 5678',
      email: 'dairk@gmail.com',
      address: 'Av. Ejemplo 123, Arica',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),

            const SizedBox(height: 16),

            Text(
              patient.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text('RUT: ${patient.rut}', style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 32),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Información personal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            _ProfileItem(
              icon: Icons.phone,
              title: 'Teléfono',
              value: patient.phone,
            ),

            _ProfileItem(
              icon: Icons.email,
              title: 'Correo',
              value: patient.email,
            ),

            _ProfileItem(
              icon: Icons.home,
              title: 'Dirección',
              value: patient.address,
            ),

            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Seguridad',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            _ProfileItem(
              icon: Icons.lock_outline,
              title: 'Contraseña',
              value: 'Cambiar contraseña',
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
