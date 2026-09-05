import 'package:flutter_test/flutter_test.dart';
import 'package:portal_paciente/main.dart';

void main() {
  testWidgets('La aplicación inicia correctamente', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortalPacienteApp());

    expect(find.text('Portal del Paciente'), findsOneWidget);
    expect(find.text('Ingresa a tu cuenta'), findsOneWidget);
  });
}
