import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const PortalPacienteApp());
}

class PortalPacienteApp extends StatelessWidget {
  const PortalPacienteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portal del Paciente',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
