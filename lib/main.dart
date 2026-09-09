import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

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
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
}
