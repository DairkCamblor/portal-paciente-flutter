import 'package:flutter_test/flutter_test.dart';
import 'package:portal_paciente/main.dart';

void main() {
  testWidgets('La aplicación inicia correctamente', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortalPacienteApp());

    // La aplicación inicia en la pantalla de bienvenida.
    expect(find.text('Bienvenido al Portal del Paciente'), findsOneWidget);

    // Desde ahí se accede al inicio de sesión.
    await tester.ensureVisible(find.text('Ya tengo cuenta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ya tengo cuenta'));
    await tester.pumpAndSettle();

    expect(find.text('Portal del Paciente'), findsOneWidget);
    expect(find.text('Ingresa a tu cuenta'), findsOneWidget);
  });
}
