import 'profile_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'appointments_screen.dart';
import 'package:portal_paciente/models/patient.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Patient patient = const Patient(
    name: 'Dairk Camblor',
    rut: '20.885.184-5',
    phone: '+56 9 1234 5678',
    email: 'dairk@gmail.com',
    address: 'Av. Ejemplo 123, Arica',
  );

  int indiceActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: indiceActual,
        children: [ 
        const HomeScreen(),
          const AppointmentsScreen(),
          ProfileScreen(patient: patient),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: indiceActual,
        onDestinationSelected: (indice) {
          setState(() {
            indiceActual = indice;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Horas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
