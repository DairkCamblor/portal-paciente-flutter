import 'package:flutter/material.dart';

/// Par de colores (fondo + texto/icono) para un estado visual.
///
/// Las combinaciones de [AppColors] se verificaron con contraste WCAG:
/// todas las parejas texto/fondo superan 4.5:1.
class StatusStyle {
  final Color background;
  final Color foreground;
  final IconData icon;

  const StatusStyle({
    required this.background,
    required this.foreground,
    required this.icon,
  });
}

/// Paleta provisional del Portal del Paciente.
///
/// Se reemplazará cuando exista la identidad oficial del hospital.
class AppColors {
  AppColors._();

  // ── Marca ──────────────────────────────────
  static const Color primary = Color(0xFF1565C0); // 5.75:1 sobre blanco
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primarySoft = Color(
    0xFFE3F0FC,
  ); // primary sobre este: 4.96:1

  /// Verde azulado de acento. Se usa 00796B (5.32:1 sobre blanco) en lugar
  /// de 00897B (4.32:1), que no alcanza el mínimo para texto.
  static const Color accent = Color(0xFF00796B);
  static const Color accentDark = Color(0xFF00695C);
  static const Color accentSoft = Color(
    0xFFE0F2F1,
  ); // accentDark sobre este: 5.71:1

  // ── Fondos y superficies ───────────────────
  static const Color background = Color(0xFFF7F9FC);
  static const Color surface = Colors.white;
  static const Color surfaceMuted = Color(0xFFEEF2F7);

  // ── Bordes ─────────────────────────────────
  /// Borde decorativo de tarjetas y separadores.
  static const Color border = Color(0xFFD5DDE8);

  /// Borde de campos de formulario (3.66:1 sobre blanco, supera 3:1).
  static const Color inputBorder = Color(0xFF7B8794);

  // ── Texto ──────────────────────────────────
  static const Color textPrimary = Color(0xFF1F2937); // 13.9:1 sobre background
  static const Color textSecondary = Color(
    0xFF4B5563,
  ); // 7.2:1 sobre background
  static const Color textOnPrimary = Colors.white;

  // ── Estados semánticos ─────────────────────
  static const Color success = Color(0xFF2E7D32); // 5.13:1 sobre blanco
  static const Color successSoft = Color(0xFFE8F5E9);
  static const Color successText = Color(
    0xFF1B5E20,
  ); // sobre successSoft: 7.00:1

  static const Color warning = Color(0xFFB45309); // 5.02:1 sobre blanco
  static const Color warningSoft = Color(0xFFFFF3E0);
  static const Color warningText = Color(
    0xFF8A3B00,
  ); // sobre warningSoft: 7.08:1

  static const Color error = Color(0xFFC62828); // 5.62:1 sobre blanco
  static const Color errorSoft = Color(0xFFFDECEA);
  static const Color errorText = Color(0xFFB71C1C); // sobre errorSoft: 5.74:1

  static const Color info = Color(0xFF1565C0);
  static const Color infoSoft = Color(0xFFE3F2FD);
  static const Color infoText = Color(0xFF0D47A1); // sobre infoSoft: 7.56:1

  static const Color neutralSoft = Color(0xFFECEFF3);
  static const Color neutralText = Color(
    0xFF374151,
  ); // sobre neutralSoft: 8.94:1

  // ── Estilos por estado ─────────────────────
  static const StatusStyle statusPending = StatusStyle(
    background: warningSoft,
    foreground: warningText,
    icon: Icons.schedule,
  );

  static const StatusStyle statusInTreatment = StatusStyle(
    background: infoSoft,
    foreground: infoText,
    icon: Icons.healing_outlined,
  );

  static const StatusStyle statusScheduled = StatusStyle(
    background: accentSoft,
    foreground: accentDark,
    icon: Icons.event_available_outlined,
  );

  static const StatusStyle statusSigned = StatusStyle(
    background: successSoft,
    foreground: successText,
    icon: Icons.check_circle_outline,
  );

  static const StatusStyle statusDischarged = StatusStyle(
    background: neutralSoft,
    foreground: neutralText,
    icon: Icons.logout,
  );

  static const StatusStyle statusError = StatusStyle(
    background: errorSoft,
    foreground: errorText,
    icon: Icons.error_outline,
  );

  /// Devuelve el estilo asociado al texto de un estado.
  ///
  /// Reconoce Pendiente, En tratamiento, Agendado/a, Firmado/a, Egresado/a,
  /// "Egresado - En control" (información) y Cancelado/Rechazado. Cualquier
  /// otro valor usa el estilo neutro.
  static StatusStyle statusStyle(String status) {
    final value = status.trim().toLowerCase();

    if (value.contains('control')) return statusInTreatment;
    if (value.startsWith('pendiente')) return statusPending;
    if (value.startsWith('en tratamiento')) return statusInTreatment;
    if (value.startsWith('agendad')) return statusScheduled;
    if (value.startsWith('firmad')) return statusSigned;
    if (value.startsWith('egresad')) return statusDischarged;
    if (value.startsWith('cancelad') || value.startsWith('rechazad')) {
      return statusError;
    }

    return statusDischarged;
  }
}
