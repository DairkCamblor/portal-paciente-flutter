import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Roboto';

  /// Escala tipográfica. El texto normal parte de 16 px y ningún estilo baja
  /// de 14 px. No se fija el escalado: respeta la configuración del sistema.
  ///
  /// Uso recomendado:
  /// - headlineSmall: título de pantalla
  /// - titleLarge: título del AppBar
  /// - titleMedium: título de sección
  /// - titleSmall: título de tarjeta
  /// - bodyMedium: texto normal
  /// - bodySmall / labelMedium: metadatos y etiquetas
  /// - labelSmall: insignias de estado
  /// - labelLarge: botones
  static const TextTheme _textTheme = TextTheme(
    headlineSmall: TextStyle(
      fontSize: 28,
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      height: 1.3,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      height: 1.3,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      height: 1.45,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      height: 1.45,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      height: 1.4,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      height: 1.2,
      fontWeight: FontWeight.w700,
    ),
  );

  static final ColorScheme _colorScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: AppColors.primary,
        onPrimary: AppColors.textOnPrimary,
        primaryContainer: AppColors.primarySoft,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.accent,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.accentSoft,
        onSecondaryContainer: AppColors.accentDark,
        error: AppColors.error,
        onError: Colors.white,
        errorContainer: AppColors.errorSoft,
        onErrorContainer: AppColors.errorText,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        surfaceContainerHighest: AppColors.surfaceMuted,
        outline: AppColors.inputBorder,
        outlineVariant: AppColors.border,
        surfaceTint: Colors.transparent,
      );

  static const Size _buttonMinimumSize = Size(64, 52);
  static const EdgeInsets _buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 14,
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: _fontFamily,
    colorScheme: _colorScheme,
    textTheme: _textTheme,
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: AppColors.border,

    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 1,
    ),

    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: _textTheme.titleLarge,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      shape: const Border(bottom: BorderSide(color: AppColors.border)),
    ),

    cardTheme: const CardThemeData(
      elevation: 0,
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardBorder,
        side: BorderSide(color: AppColors.border),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: _buttonMinimumSize,
        padding: _buttonPadding,
        textStyle: _textTheme.labelLarge,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.controlBorder,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: _buttonMinimumSize,
        padding: _buttonPadding,
        textStyle: _textTheme.labelLarge,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.controlBorder,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: _buttonMinimumSize,
        padding: _buttonPadding,
        textStyle: _textTheme.labelLarge,
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.controlBorder,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: _textTheme.labelLarge,
        foregroundColor: AppColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.controlBorder,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: _textTheme.bodyMedium?.copyWith(
        color: AppColors.textSecondary,
      ),
      floatingLabelStyle: _textTheme.bodyMedium?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: _textTheme.bodyMedium?.copyWith(
        color: AppColors.textSecondary,
      ),
      errorStyle: _textTheme.bodySmall?.copyWith(color: AppColors.errorText),
      prefixIconColor: AppColors.textSecondary,
      suffixIconColor: AppColors.textSecondary,
      border: const OutlineInputBorder(
        borderRadius: AppRadius.controlBorder,
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.controlBorder,
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadius.controlBorder,
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.controlBorder,
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.controlBorder,
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      height: 72,
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      indicatorColor: AppColors.primarySoft,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          size: 26,
          color: selected ? AppColors.primaryDark : AppColors.textSecondary,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(
          fontSize: 14,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.primaryDark : AppColors.textSecondary,
        );
      }),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceMuted,
      selectedColor: AppColors.primarySoft,
      labelStyle: _textTheme.labelSmall?.copyWith(color: AppColors.textPrimary),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      side: BorderSide.none,
      shape: const StadiumBorder(),
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: _textTheme.bodyMedium?.copyWith(color: Colors.white),
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.controlBorder,
      ),
    ),
  );
}
