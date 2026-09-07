import 'package:flutter/material.dart';
import 'create_password_screen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool aceptaTerminos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Términos y condiciones')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Consentimiento y términos de uso',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            const Text(
              'Antes de finalizar tu registro, debes leer y '
              'aceptar los Términos de Uso y las condiciones '
              'relacionadas con el tratamiento de tu información.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Términos de Uso\n\n'
                  'Esta sección corresponde a los términos y '
                  'condiciones que serán definidos por el hospital '
                  'para el uso del Portal del Paciente.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),

            const SizedBox(height: 24),

            CheckboxListTile(
              value: aceptaTerminos,
              onChanged: (value) {
                setState(() {
                  aceptaTerminos = value ?? false;
                });
              },
              title: const Text(
                'Acepto los Términos de Uso y las condiciones '
                'de mi información.',
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: aceptaTerminos
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreatePasswordScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Text('CONTINUAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
