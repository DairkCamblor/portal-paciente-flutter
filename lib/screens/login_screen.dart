import 'package:flutter/material.dart';
import 'home_screen.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_hospital, size: 80),

              const SizedBox(height: 24),

              const Text(
                'Portal del Paciente',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text('Ingresa a tu cuenta', style: TextStyle(fontSize: 16)),

              const SizedBox(height: 32),

              TextField(
                controller: rutController,
                decoration: InputDecoration(
                  labelText: 'RUT',
                  hintText: '12.345.678-9',
                  prefixIcon: const Icon(Icons.badge),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: contrasenaController,
                obscureText: !mostrarContrasena,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),

                  suffixIcon: IconButton(
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

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                    //En este punto, puedes agregar la lógica de autenticación y validación de credenciales.
                    //print('RUT: ${rutController.text}');
                    //print('Contraseña: ${contrasenaController.text}');
                  },
                  child: const Text(
                    'INGRESAR',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {},
                child: const Text('¿No tienes una cuenta? Registrarme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
