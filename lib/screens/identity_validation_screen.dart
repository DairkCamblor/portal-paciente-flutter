import 'package:flutter/material.dart';
import 'email_verification_screen.dart';

class IdentityValidationScreen extends StatefulWidget {
  const IdentityValidationScreen({super.key});

  @override
  State<IdentityValidationScreen> createState() =>
      _IdentityValidationScreenState();
}

class _IdentityValidationScreenState extends State<IdentityValidationScreen> {
  final TextEditingController rutController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  @override
  void dispose() {
    rutController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validación de identidad')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Validación de identidad',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Ingresa tus datos registrados en el hospital '
              'para comenzar el registro.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            const Text(
              'RUT del paciente',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: rutController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: '12.345.678-9',
                prefixIcon: Icon(Icons.badge_outlined),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Número de teléfono móvil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: telefonoController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: '+56 9 1234 5678',
                prefixIcon: Icon(Icons.phone_outlined),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmailVerificationScreen(),
                    ),
                  );
                },
                child: const Text('VERIFICAR MIS DATOS'),
              ),
            ),

            const SizedBox(height: 16),

            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tu RUT y teléfono deben coincidir con '
                    'los registros del hospital.',
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
