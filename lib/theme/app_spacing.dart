import 'package:flutter/widgets.dart';

/// Escala de espaciado compartida por toda la aplicación.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  /// Margen estándar del contenido de una pantalla.
  static const EdgeInsets screenPadding = EdgeInsets.all(20);

  /// Relleno interno estándar de una tarjeta.
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
}
