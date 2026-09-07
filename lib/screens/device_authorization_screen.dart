import 'package:flutter/material.dart';

class DeviceAuthorizationScreen extends StatefulWidget {
  const DeviceAuthorizationScreen({super.key});

  @override
  State<DeviceAuthorizationScreen> createState() =>
      _DeviceAuthorizationScreenState();
}

class _DeviceAuthorizationScreenState extends State<DeviceAuthorizationScreen> {
  bool dispositivoAutorizado = false;

  void autorizarDispositivo() {
    setState(() {
      dispositivoAutorizado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autorizar dispositivo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),

            Icon(
              dispositivoAutorizado ? Icons.verified_user : Icons.phone_android,
              size: 90,
            ),

            const SizedBox(height: 24),

            Text(
              dispositivoAutorizado
                  ? 'Dispositivo autorizado'
                  : 'Autoriza este dispositivo',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Text(
              dispositivoAutorizado
                  ? 'Este dispositivo ha sido vinculado '
                        'a tu cuenta del Portal del Paciente.'
                  : 'Por seguridad, debes autorizar este '
                        'dispositivo para acceder a tu cuenta.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            if (!dispositivoAutorizado)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(Icons.security, size: 36),
                      const SizedBox(height: 12),
                      const Text(
                        'Este dispositivo será asociado '
                        'a tu cuenta de forma segura.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Solo podrás utilizar tu cuenta '
                        'desde dispositivos autorizados.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: dispositivoAutorizado
                    ? () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    : autorizarDispositivo,
                child: Text(
                  dispositivoAutorizado
                      ? 'FINALIZAR REGISTRO'
                      : 'AUTORIZAR ESTE DISPOSITIVO',
                ),
              ),
            ),

            const SizedBox(height: 16),

            if (!dispositivoAutorizado)
              const Text(
                'También existe un proceso de autorización '
                'presencial definido por el hospital.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
          ],
        ),
      ),
    );
  }
}
