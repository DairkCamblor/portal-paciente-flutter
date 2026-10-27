import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_paciente/models/patient.dart';
import 'package:portal_paciente/screens/appointments_screen.dart';
import 'package:portal_paciente/screens/authorizations_screen.dart';
import 'package:portal_paciente/screens/exams_screen.dart';
import 'package:portal_paciente/screens/first_attention_screen.dart';
import 'package:portal_paciente/screens/home_screen.dart';
import 'package:portal_paciente/screens/kinesiology_screen.dart';
import 'package:portal_paciente/screens/laboratory_screen.dart';
import 'package:portal_paciente/screens/login_screen.dart';
import 'package:portal_paciente/screens/main_screen.dart';
import 'package:portal_paciente/screens/notifications_screen.dart';
import 'package:portal_paciente/screens/prescription_detail_screen.dart';
import 'package:portal_paciente/screens/prescriptions_screen.dart';
import 'package:portal_paciente/screens/procedures_screen.dart';
import 'package:portal_paciente/screens/profile_screen.dart';
import 'package:portal_paciente/screens/referrals_screen.dart';
import 'package:portal_paciente/screens/turnos_screen.dart';
import 'package:portal_paciente/screens/welcome_screen.dart';

import 'helpers/test_harness.dart';

const _patient = Patient(
  name: 'Dairk Camblor',
  rut: '20.885.184-5',
  phone: '+56 9 1234 5678',
  email: 'dairk@gmail.com',
  address: 'Av. Ejemplo 123, Arica',
);

/// Monta [screen] con el ancho y la escala de texto indicados.
Future<void> _pump(
  WidgetTester tester,
  Widget screen, {
  required double width,
  required double scale,
  double height = 740,
  double keyboard = 0,
}) async {
  setViewport(tester, Size(width, height));
  tester.view.viewInsets = FakeViewPadding(bottom: keyboard);
  addTearDown(tester.view.resetViewInsets);
  await tester.pumpWidget(const SizedBox());
  await tester.pumpWidget(testApp(screen, textScale: scale));
  await tester.pumpAndSettle();
}

void _expectNoLayoutErrors(WidgetTester tester, [String? reason]) {
  expect(drainExceptions(tester), isEmpty, reason: reason);
}

void main() {
  setUpAll(loadRoboto);

  final screens = <String, Widget Function()>{
    'Welcome': () => const WelcomeScreen(),
    'Login': () => const LoginScreen(),
    'Home': () => const HomeScreen(),
    'Main': () => const MainScreen(),
    'Perfil': () => const ProfileScreen(patient: _patient),
    'Autorizaciones': () => const AuthorizationsScreen(),
    'Mis horas': () => const AppointmentsScreen(),
    'Exámenes': () => const ExamsScreen(),
    'Laboratorio': () => const LaboratoryScreen(),
    'Recetas': () => const PrescriptionsScreen(),
    'Derivaciones': () => const ReferralsScreen(),
    'Primera atención': () => const FirstAttentionScreen(),
    'Procedimientos': () => const ProceduresScreen(),
    'Kinesiología': () => const KinesiologyScreen(),
    'Notificaciones': () => const NotificationsScreen(),
    'Turnos': () => const TurnosScreen(),
  };

  group('Sin desbordes (todos los anchos y escalas de texto)', () {
    for (final entry in screens.entries) {
      for (final width in testWidths) {
        for (final scale in testTextScales) {
          testWidgets('${entry.key} · ${width.toInt()} px · x$scale', (
            tester,
          ) async {
            await _pump(tester, entry.value(), width: width, scale: scale);
            _expectNoLayoutErrors(tester);
          });
        }
      }
    }
  });

  group('Perfil', () {
    for (final width in testWidths) {
      for (final scale in testTextScales) {
        testWidgets('diálogos de edición · ${width.toInt()} px · x$scale', (
          tester,
        ) async {
          await _pump(
            tester,
            const ProfileScreen(patient: _patient),
            width: width,
            scale: scale,
          );

          final editContact = find.widgetWithText(TextButton, 'Editar').first;
          await tester.ensureVisible(editContact);
          await tester.tap(editContact);
          await tester.pumpAndSettle();
          expect(find.text('Editar datos de contacto'), findsOneWidget);
          _expectNoLayoutErrors(tester, 'diálogo de contacto');

          await tester.tap(find.text('Continuar'));
          await tester.pumpAndSettle();
          expect(find.text('Confirmar cambio'), findsOneWidget);
          _expectNoLayoutErrors(tester, 'diálogo de confirmación');
        });
      }
    }

    testWidgets('diálogo de dirección con teclado abierto', (tester) async {
      await _pump(
        tester,
        const ProfileScreen(patient: _patient),
        width: 360,
        scale: 1.5,
        keyboard: 300,
      );

      final editAddress = find.widgetWithText(TextButton, 'Editar').last;
      await tester.ensureVisible(editAddress);
      await tester.tap(editAddress);
      await tester.pumpAndSettle();
      expect(find.text('Editar dirección'), findsOneWidget);
      _expectNoLayoutErrors(tester);
    });

    testWidgets('cerrar sesión y filas de seguridad siguen activos', (
      tester,
    ) async {
      await _pump(
        tester,
        const ProfileScreen(patient: _patient),
        width: 360,
        scale: 1.0,
        height: 1600,
      );

      await tester.tap(find.text('Cambiar contraseña'));
      await tester.pump();
      expect(
        find.text('Cambio de contraseña disponible próximamente.'),
        findsOneWidget,
      );

      await tester.tap(find.widgetWithText(OutlinedButton, 'Cerrar sesión'));
      await tester.pumpAndSettle();
      expect(
        find.text('¿Estás seguro de que deseas cerrar sesión?'),
        findsOneWidget,
      );
    });
  });

  group('Autorizaciones', () {
    for (final width in testWidths) {
      for (final scale in testTextScales) {
        testWidgets('hoja de detalle · ${width.toInt()} px · x$scale', (
          tester,
        ) async {
          await _pump(
            tester,
            const AuthorizationsScreen(),
            width: width,
            scale: scale,
          );

          // Documento pendiente
          final pending = find.text('Consentimiento informado').first;
          await tester.ensureVisible(pending);
          await tester.pumpAndSettle();
          await tester.tap(pending);
          await tester.pumpAndSettle();
          expect(find.text('Continuar'), findsOneWidget);
          _expectNoLayoutErrors(tester, 'detalle pendiente');

          // A escala grande la hoja es desplazable: hay que bajar hasta el botón.
          await tester.ensureVisible(find.text('Cerrar'));
          await tester.pumpAndSettle();
          await tester.tap(find.text('Cerrar'));
          await tester.pumpAndSettle();

          // Documento firmado
          final signed = find.text('Autorización de procedimiento');
          await tester.dragUntilVisible(
            signed,
            find.byType(ListView),
            const Offset(0, -200),
          );
          await tester.pumpAndSettle();
          await tester.tap(signed);
          await tester.pumpAndSettle();
          expect(find.text('Ver documento'), findsOneWidget);
          _expectNoLayoutErrors(tester, 'detalle firmado');
        });
      }
    }

    testWidgets('el título de sección se ajusta en varias líneas', (
      tester,
    ) async {
      await _pump(tester, const AuthorizationsScreen(), width: 320, scale: 2.0);
      _expectNoLayoutErrors(tester);
      expect(find.text('Documentos pendientes'), findsOneWidget);
      await tester.dragUntilVisible(
        find.text('Documentos firmados'),
        find.byType(ListView),
        const Offset(0, -200),
      );
      _expectNoLayoutErrors(tester);
    });
  });

  group('Estados internos del resto de módulos', () {
    for (final width in testWidths) {
      for (final scale in testTextScales) {
        final label = '${width.toInt()} px · x$scale';

        testWidgets('Kinesiología: detalle · $label', (tester) async {
          await _pump(
            tester,
            const KinesiologyScreen(),
            width: width,
            scale: scale,
          );
          final card = find.text('Traumatología').first;
          await tester.ensureVisible(card);
          await tester.pumpAndSettle();
          await tester.tap(card);
          await tester.pumpAndSettle();
          expect(find.text('Cerrar'), findsOneWidget);
          _expectNoLayoutErrors(tester);
        });

        testWidgets('Procedimientos y primera atención: detalle · $label', (
          tester,
        ) async {
          await _pump(
            tester,
            const ProceduresScreen(),
            width: width,
            scale: scale,
          );
          await tester.tap(find.text('Resonancia magnética'));
          await tester.pumpAndSettle();
          expect(find.text('Cerrar'), findsOneWidget);
          _expectNoLayoutErrors(tester, 'procedimientos');

          await _pump(
            tester,
            const FirstAttentionScreen(),
            width: width,
            scale: scale,
          );
          await tester.tap(find.text('Cardiología'));
          await tester.pumpAndSettle();
          expect(find.text('Cerrar'), findsOneWidget);
          _expectNoLayoutErrors(tester, 'primera atención');
        });

        testWidgets('Recetas: detalle de receta · $label', (tester) async {
          await _pump(
            tester,
            const PrescriptionsScreen(),
            width: width,
            scale: scale,
          );
          await tester.tap(find.text('Receta N.º 886724'));
          await tester.pumpAndSettle();
          expect(find.byType(PrescriptionDetailScreen), findsOneWidget);
          _expectNoLayoutErrors(tester);
        });

        testWidgets('Turnos: turno activo y detalle · $label', (tester) async {
          await _pump(tester, const TurnosScreen(), width: width, scale: scale);
          await tester.tap(find.widgetWithText(FilledButton, 'Obtener turno'));
          await tester.pumpAndSettle();
          expect(find.text('Tienes un turno activo'), findsOneWidget);
          _expectNoLayoutErrors(tester, 'turno activo');

          final detail = find.widgetWithText(OutlinedButton, 'Ver detalle');
          await tester.ensureVisible(detail);
          await tester.pumpAndSettle();
          await tester.tap(detail);
          await tester.pumpAndSettle();
          expect(find.text('Detalle de tu turno'), findsOneWidget);
          _expectNoLayoutErrors(tester, 'detalle del turno');
        });
      }
    }
  });

  group('Navegación existente', () {
    testWidgets('Derivaciones abre sus tres módulos', (tester) async {
      final destinos = {
        'Primera atención': FirstAttentionScreen,
        'Procedimientos': ProceduresScreen,
        'Kinesiología': KinesiologyScreen,
      };

      for (final entry in destinos.entries) {
        await _pump(
          tester,
          const ReferralsScreen(),
          width: 360,
          scale: 1.0,
          height: 1000,
        );
        await tester.tap(find.text(entry.key));
        await tester.pumpAndSettle();
        expect(find.byType(entry.value), findsOneWidget, reason: entry.key);
      }
    });

    testWidgets('Exámenes abre Laboratorio', (tester) async {
      await _pump(tester, const ExamsScreen(), width: 360, scale: 1.0);
      await tester.tap(find.text('Laboratorio'));
      await tester.pumpAndSettle();
      expect(find.byType(LaboratoryScreen), findsOneWidget);
    });

    testWidgets('Notificaciones abre el módulo relacionado', (tester) async {
      await _pump(
        tester,
        const NotificationsScreen(),
        width: 360,
        scale: 1.0,
        height: 1400,
      );
      await tester.tap(find.text('Cambio de hora médica'));
      await tester.pumpAndSettle();
      expect(find.byType(AppointmentsScreen), findsOneWidget);
    });
  });
}
