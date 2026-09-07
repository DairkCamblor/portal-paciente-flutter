import 'package:flutter/material.dart';
import 'terms_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController codigoController = TextEditingController();

  bool codigoEnviado = false;

  @override
  void dispose() {
    codigoController.dispose();
    super.dispose();
  }

  void enviarCodigo() {
    setState(() {
      codigoEnviado = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Código de verificación enviado.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verificación')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verificación de identidad',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            const Text(
              'Tus datos fueron verificados correctamente.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            const Text(
              'Correo de contacto registrado',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(),
              ),
              child: const Text(
                'd***k@gmail.com',
                style: TextStyle(fontSize: 17),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Se enviará un código de verificación de 6 dígitos '
              'a este correo electrónico.',
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: enviarCodigo,
                child: Text(
                  codigoEnviado ? 'REENVIAR CÓDIGO' : 'ENVIAR CÓDIGO',
                ),
              ),
            ),

            if (codigoEnviado) ...[
              const SizedBox(height: 28),

              const Text(
                'Código de verificación',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: codigoController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  hintText: 'Ingresa los 6 dígitos',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsScreen(),
                      ),
                    );
                  },
                  child: const Text('VERIFICAR CÓDIGO'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
