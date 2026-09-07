import 'package:flutter/material.dart';
import 'device_authorization_screen.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool mostrarPassword = false;
  bool mostrarConfirmacion = false;

  bool get tieneLongitudMinima => passwordController.text.length >= 8;

  bool get tieneMayuscula => passwordController.text.contains(RegExp(r'[A-Z]'));

  bool get tieneNumero => passwordController.text.contains(RegExp(r'[0-9]'));

  bool get tieneSimbolo => passwordController.text.contains(
    RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\\/]'),
  );

  bool get contrasenasCoinciden =>
      passwordController.text.isNotEmpty &&
      passwordController.text == confirmPasswordController.text;

  bool get formularioValido =>
      tieneLongitudMinima &&
      tieneMayuscula &&
      tieneNumero &&
      tieneSimbolo &&
      contrasenasCoinciden;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear clave')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Crea tu clave de acceso',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            const Text(
              'Utiliza una clave segura que puedas recordar. '
              'La utilizarás para ingresar al Portal del Paciente.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            const Text(
              'Nueva clave',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: passwordController,
              obscureText: !mostrarPassword,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Ingresa tu clave',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      mostrarPassword = !mostrarPassword;
                    });
                  },
                  icon: Icon(
                    mostrarPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'La clave debe contener:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            _PasswordRequirement(
              text: 'Mínimo 8 caracteres',
              cumplido: tieneLongitudMinima,
            ),

            _PasswordRequirement(
              text: 'Al menos una letra mayúscula',
              cumplido: tieneMayuscula,
            ),

            _PasswordRequirement(
              text: 'Al menos un número',
              cumplido: tieneNumero,
            ),

            _PasswordRequirement(
              text: 'Al menos un símbolo',
              cumplido: tieneSimbolo,
            ),

            const SizedBox(height: 24),

            const Text(
              'Confirmar clave',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: confirmPasswordController,
              obscureText: !mostrarConfirmacion,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Repite tu clave',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      mostrarConfirmacion = !mostrarConfirmacion;
                    });
                  },
                  icon: Icon(
                    mostrarConfirmacion
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            if (confirmPasswordController.text.isNotEmpty)
              _PasswordRequirement(
                text: 'Las claves coinciden',
                cumplido: contrasenasCoinciden,
              ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: formularioValido
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DeviceAuthorizationScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Text('CREAR CLAVE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordRequirement extends StatelessWidget {
  final String text;
  final bool cumplido;

  const _PasswordRequirement({required this.text, required this.cumplido});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            cumplido ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
