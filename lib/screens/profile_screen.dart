import 'package:flutter/material.dart';

import 'package:portal_paciente/models/patient.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/info_row.dart';
import '../widgets/portal_card.dart';
import '../widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  final Patient patient;

  const ProfileScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // PERFIL DEL PACIENTE
                const Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: AppColors.primarySoft,
                    foregroundColor: AppColors.primary,
                    child: Icon(Icons.person, size: 50),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                Text(
                  patient.name,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  'RUT: ${patient.rut}',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),

                // DATOS PERSONALES
                const SectionHeader('Datos personales'),

                _InfoCard(
                  children: [
                    InfoRow(
                      icon: Icons.badge_outlined,
                      label: 'RUT',
                      value: patient.rut,
                      padding: EdgeInsets.zero,
                    ),
                    InfoRow(
                      icon: Icons.person_outline,
                      label: 'Nombre completo',
                      value: patient.name,
                      padding: EdgeInsets.zero,
                    ),
                    const InfoRow(
                      icon: Icons.cake_outlined,
                      label: 'Fecha de nacimiento',
                      value: '10-10-2001',
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),

                // DATOS DE CONTACTO
                SectionHeader(
                  'Datos de contacto',
                  trailing: TextButton.icon(
                    onPressed: () {
                      _showEditContactDialog(context);
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar'),
                  ),
                ),

                _InfoCard(
                  children: [
                    InfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Teléfono principal',
                      value: patient.phone,
                      padding: EdgeInsets.zero,
                    ),
                    InfoRow(
                      icon: Icons.email_outlined,
                      label: 'Correo electrónico',
                      value: patient.email.isEmpty
                          ? 'No registrado'
                          : patient.email,
                      padding: EdgeInsets.zero,
                    ),
                    const InfoRow(
                      icon: Icons.phone_android_outlined,
                      label: 'Teléfono secundario',
                      value: 'No registrado',
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // DIRECCIÓN
                PortalCard(
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        'Dirección',
                        icon: Icons.location_on_outlined,
                        trailing: TextButton(
                          onPressed: () {
                            _showEditAddressDialog(context);
                          },
                          child: const Text('Editar'),
                        ),
                      ),

                      Text(
                        patient.address.isEmpty
                            ? 'No registrada'
                            : patient.address,
                        style: textTheme.bodyMedium,
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        'Información registrada actualmente en el hospital.',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // SEGURIDAD
                const SectionHeader('Seguridad'),

                PortalCard(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _ProfileAction(
                        icon: Icons.lock_outline,
                        title: 'Cambiar contraseña',
                        subtitle: 'Actualiza tu clave de acceso',
                        onTap: () {
                          _showComingSoon(
                            context,
                            'Cambio de contraseña disponible próximamente.',
                          );
                        },
                      ),
                      const Divider(),
                      _ProfileAction(
                        icon: Icons.smartphone_outlined,
                        title: 'Dispositivo autorizado',
                        subtitle: 'Este dispositivo está autorizado',
                        onTap: () {
                          _showComingSoon(
                            context,
                            'Gestión del dispositivo disponible próximamente.',
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // INFORMACIÓN DE SINCRONIZACIÓN
                PortalCard(
                  margin: EdgeInsets.zero,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.sync_outlined,
                        size: MediaQuery.textScalerOf(context).scale(24),
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Información institucional',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Los datos mostrados corresponden a la información registrada en los sistemas institucionales.',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // CERRAR SESIÓN
                OutlinedButton.icon(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Cerrar sesión'),
                ),

                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditContactDialog(BuildContext context) {
    final phoneController = TextEditingController(text: patient.phone);

    final emailController = TextEditingController(text: patient.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar datos de contacto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono principal',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Los cambios podrían requerir una verificación adicional.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                _showChangeAuthorization(context, 'contacto');
              },
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );
  }

  void _showEditAddressDialog(BuildContext context) {
    final addressController = TextEditingController(text: patient.address);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar dirección'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: addressController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Dirección',
                    prefixIcon: Icon(Icons.home_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Número',
                    prefixIcon: Icon(Icons.numbers_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Comuna',
                    prefixIcon: Icon(Icons.location_city_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'La información será validada antes de confirmar el cambio.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                _showChangeAuthorization(context, 'dirección');
              },
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );
  }

  void _showChangeAuthorization(BuildContext context, String tipoCambio) {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar cambio'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Para modificar tus datos de $tipoCambio, ingresa tu clave de acceso.',
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Clave de acceso',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'El sistema podrá solicitar una verificación adicional para confirmar el cambio.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cambio enviado para validación.'),
                  ),
                );
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sesión cerrada.')),
                );
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );
  }

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

/// Tarjeta que agrupa filas de información separadas por divisores.
class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return PortalCard(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const Divider(height: AppSpacing.xl),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _ProfileAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle, style: textTheme.bodySmall),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
