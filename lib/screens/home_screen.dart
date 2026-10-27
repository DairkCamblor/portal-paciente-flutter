import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../widgets/icon_tile.dart';
import '../widgets/portal_card.dart';
import '../widgets/screen_header.dart';
import '../widgets/section_header.dart';
import 'appointments_screen.dart';
import 'authorizations_screen.dart';
import 'exams_screen.dart';
import 'notifications_screen.dart';
import 'prescriptions_screen.dart';
import 'referrals_screen.dart';
import 'turnos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Con texto ampliado o pantallas angostas, los títulos largos no caben en
  /// dos columnas; en ese caso las tarjetas pasan a una columna.
  static const double _maxTextScaleForTwoColumns = 1.15;
  static const double _minWidthForTwoColumns = 340;

  @override
  Widget build(BuildContext context) {
    final menuItems = <_MenuItem>[
      _MenuItem(
        icon: Icons.calendar_month,
        title: 'Mis horas',
        page: () => const AppointmentsScreen(),
      ),
      _MenuItem(
        icon: Icons.science,
        title: 'Exámenes',
        page: () => const ExamsScreen(),
      ),
      _MenuItem(
        icon: Icons.medication_outlined,
        title: 'Recetas',
        page: () => const PrescriptionsScreen(),
      ),
      _MenuItem(
        icon: Icons.assignment_outlined,
        title: 'Interconsultas',
        page: () => const ReferralsScreen(),
      ),
      _MenuItem(
        icon: Icons.assignment_turned_in_outlined,
        title: 'Autorizaciones – Firmas',
        page: () => const AuthorizationsScreen(),
      ),
      _MenuItem(
        icon: Icons.confirmation_number_outlined,
        title: 'Turnos de atención',
        page: () => const TurnosScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Portal de Salud'),
        actions: [
          IconButton(
            tooltip: 'Notificaciones',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScreenHeader(
                  'Bienvenido',
                  subtitle:
                      'Consulta tu información y gestiona tus atenciones.',
                ),

                const _NextAppointmentCard(),

                const SizedBox(height: AppSpacing.xl),

                const SectionHeader('¿Qué necesitas?'),

                _MenuGrid(
                  items: menuItems,
                  maxTextScale: _maxTextScaleForTwoColumns,
                  minWidth: _minWidthForTwoColumns,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRÓXIMA ATENCIÓN
// ─────────────────────────────────────────────

class _NextAppointmentCard extends StatelessWidget {
  const _NextAppointmentCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PortalCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconTile(Icons.event_available_outlined, size: 52),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Próxima atención', style: textTheme.labelMedium),
                    const SizedBox(height: 2),
                    Text('Medicina General', style: textTheme.titleMedium),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: AppRadius.controlBorder,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HighlightLine(
                  icon: Icons.calendar_today_outlined,
                  text: '10 de septiembre',
                ),
                SizedBox(height: AppSpacing.sm),
                _HighlightLine(icon: Icons.schedule, text: '09:30'),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppointmentsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward),
            iconAlignment: IconAlignment.end,
            label: const Text('Ver detalles'),
          ),
        ],
      ),
    );
  }
}

class _HighlightLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _HighlightLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.textScalerOf(context).scale(24);

    return Row(
      children: [
        Icon(icon, size: iconSize, color: AppColors.primaryDark),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// MENÚ
// ─────────────────────────────────────────────

class _MenuItem {
  final IconData icon;
  final String title;
  final Widget Function() page;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.page,
  });
}

/// Grilla de dos columnas cuyas tarjetas se ajustan a su contenido.
///
/// Las tarjetas de una misma fila tienen la misma altura. Si el texto está
/// muy ampliado o el ancho es reducido, cae a una columna con tarjetas
/// horizontales.
class _MenuGrid extends StatelessWidget {
  final List<_MenuItem> items;
  final double maxTextScale;
  final double minWidth;

  const _MenuGrid({
    required this.items,
    required this.maxTextScale,
    required this.minWidth,
  });

  void _open(BuildContext context, _MenuItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => item.page()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns =
            textScale <= maxTextScale && constraints.maxWidth >= minWidth;

        if (!twoColumns) {
          return Column(
            children: [
              for (final item in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _MenuCard(
                    item: item,
                    horizontal: true,
                    onTap: () => _open(context, item),
                  ),
                ),
            ],
          );
        }

        return Column(
          children: [
            for (var i = 0; i < items.length; i += 2)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _MenuCard(
                          item: items[i],
                          onTap: () => _open(context, items[i]),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: i + 1 < items.length
                            ? _MenuCard(
                                item: items[i + 1],
                                onTap: () => _open(context, items[i + 1]),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _MenuCard extends StatelessWidget {
  final _MenuItem item;
  final bool horizontal;
  final VoidCallback onTap;

  const _MenuCard({
    required this.item,
    required this.onTap,
    this.horizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, height: 1.25);

    if (horizontal) {
      return PortalCard(
        margin: EdgeInsets.zero,
        onTap: onTap,
        child: Row(
          children: [
            IconTile(item.icon),
            const SizedBox(width: AppSpacing.lg),
            Expanded(child: Text(item.title, style: titleStyle)),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      );
    }

    return PortalCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTile(item.icon),
          const SizedBox(height: AppSpacing.md),
          Text(item.title, textAlign: TextAlign.center, style: titleStyle),
        ],
      ),
    );
  }
}
