import 'package:flutter/material.dart';
import 'package:portal_paciente/models/appointment.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final List<Appointment> horas = [
    const Appointment(
      specialty: 'Medicina General',
      doctor: 'Dr. García',
      date: '10 de septiembre',
      time: '09:30',
      location: 'Hospital Regional',
    ),
    const Appointment(
      specialty: 'Odontología',
      doctor: 'Dra. Martínez',
      date: '18 de septiembre',
      time: '15:00',
      location: 'Centro de Especialidades',
    ),
    const Appointment(
      specialty: 'Cardiología',
      doctor: 'Dr. López',
      date: '25 de septiembre',
      time: '11:00',
      location: 'Hospital Regional',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis horas')),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Próximas atenciones',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: horas.length,
            itemBuilder: (context, index) {
              final hora = horas[index];

              return _AppointmentCard(
                specialty: hora.specialty,
                doctor: hora.doctor,
                date: hora.date,
                time: hora.time,
                location: hora.location,
                icon: Icons.medical_services_outlined,
              );
            },
          ),

          const SizedBox(height: 24),

          const Text(
            'Historial',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          _HistoryItem(
            specialty: 'Medicina General',
            date: '02 de agosto de 2026',
          ),

          _HistoryItem(specialty: 'Laboratorio', date: '15 de julio de 2026'),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String specialty;
  final String doctor;
  final String date;
  final String time;
  final String location;
  final IconData icon;

  const _AppointmentCard({
    required this.specialty,
    required this.doctor,
    required this.date,
    required this.time,
    required this.location,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    specialty,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(doctor),

            const SizedBox(height: 6),

            Text('$date · $time'),

            const SizedBox(height: 6),

            Text(location),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Ver detalles'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String specialty;
  final String date;

  const _HistoryItem({required this.specialty, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.check_circle_outline),
      title: Text(specialty),
      subtitle: Text(date),
    );
  }
}
