import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../widgets/brand_header.dart';
import '../widgets/screen_header.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool mostrarContrasena = false;
  final TextEditingController rutController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  @override
  void dispose() {
    rutController.dispose();
    contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            const BrandHeader(compact: true),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    AppSpacing.xl,
                    AppSpacing.xl,
                    AppSpacing.xl + bottomInset,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const ScreenHeader(
                        'Portal del Paciente',
                        subtitle: 'Ingresa a tu cuenta',
                        padding: EdgeInsets.only(bottom: AppSpacing.xl),
                      ),

                      TextField(
                        controller: rutController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'RUT',
                          hintText: '12.345.678-9',
                          prefixIcon: Icon(Icons.badge_outlined),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      TextField(
                        controller: contrasenaController,
                        obscureText: !mostrarContrasena,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            tooltip: mostrarContrasena
                                ? 'Ocultar contraseña'
                                : 'Mostrar contraseña',
                            onPressed: () {
                              setState(() {
                                mostrarContrasena = !mostrarContrasena;
                              });
                            },
                            icon: Icon(
                              mostrarContrasena
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                          );
                          //En este punto, puedes agregar la lógica de autenticación y validación de credenciales.
                          //print('RUT: ${rutController.text}');
                          //print('Contraseña: ${contrasenaController.text}');
                        },
                        child: const Text('Ingresar'),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      const Divider(),

                      const SizedBox(height: AppSpacing.sm),

                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          '¿No tienes una cuenta? Registrarme',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
