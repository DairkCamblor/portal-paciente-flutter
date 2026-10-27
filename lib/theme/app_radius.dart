import 'package:flutter/widgets.dart';

/// Radios de borde compartidos por toda la aplicación.
class AppRadius {
  AppRadius._();

  /// Botones, campos de texto y elementos de control.
  static const double control = 12;

  /// Tarjetas y contenedores de icono.
  static const double card = 16;

  /// Insignias y chips.
  static const double pill = 999;

  static const BorderRadius controlBorder = BorderRadius.all(
    Radius.circular(control),
  );
  static const BorderRadius cardBorder = BorderRadius.all(
    Radius.circular(card),
  );
  static const BorderRadius pillBorder = BorderRadius.all(
    Radius.circular(pill),
  );
}
