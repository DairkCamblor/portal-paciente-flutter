import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_paciente/theme/app_theme.dart';

/// Anchos (en px lógicos) y escalas de texto que se validan en las pruebas.
const testWidths = <double>[320, 360, 390];
const testTextScales = <double>[1.0, 1.3, 1.5, 2.0];

bool _fontsLoaded = false;

/// Carga Roboto real desde el SDK de Flutter.
///
/// Por defecto `flutter test` dibuja el texto con la fuente Ahem, cuyas letras
/// son cuadrados tan anchos como altos y exageran los desbordamientos. Con
/// Roboto las medidas se parecen a las del dispositivo. Si no se encuentra la
/// fuente, las pruebas siguen funcionando con Ahem (más estrictas).
Future<void> loadRoboto() async {
  if (_fontsLoaded) return;
  _fontsLoaded = true;

  final root = Platform.environment['FLUTTER_ROOT'];
  if (root == null) return;

  final dir = '$root/bin/cache/artifacts/material_fonts';
  final files = [
    'roboto-regular.ttf',
    'roboto-medium.ttf',
    'roboto-bold.ttf',
    'roboto-italic.ttf',
  ];

  final loader = FontLoader('Roboto');
  var found = false;
  for (final name in files) {
    final file = File('$dir/$name');
    if (file.existsSync()) {
      found = true;
      loader.addFont(file.readAsBytes().then((b) => ByteData.sublistView(b)));
    }
  }
  if (found) await loader.load();
}

/// Envuelve [home] con el tema de la app y una escala de texto fija.
Widget testApp(Widget home, {double textScale = 1.0}) {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(textScale)),
      child: child!,
    ),
    home: home,
  );
}

/// Ajusta el tamaño de la ventana de prueba y lo restaura al terminar.
void setViewport(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

/// Recoge todas las excepciones pendientes del test como texto resumido.
List<String> drainExceptions(WidgetTester tester) {
  final result = <String>[];
  Object? e;
  while ((e = tester.takeException()) != null) {
    final lines = e.toString().split('\n');
    result.add(lines.firstWhere((l) => l.trim().isNotEmpty, orElse: () => ''));
  }
  return result;
}
