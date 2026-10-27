import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../widgets/brand_header.dart';
import 'identity_validation_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  const BrandHeader(),

                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          AppSpacing.xl,
                          AppSpacing.xxl,
                          AppSpacing.xl,
                          AppSpacing.xl + bottomInset,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Semantics(
                              header: true,
                              child: Text(
                                'Bienvenido al Portal del Paciente',
                                textAlign: TextAlign.center,
                                style: textTheme.headlineSmall,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.md),

                            Text(
                              'Consulta tus horas, exámenes, recetas y '
                              'documentos desde un solo lugar.',
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.xxl),

                            FilledButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const IdentityValidationScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.person_add_alt_1_outlined),
                              label: const Text(
                                'Registrarme como paciente adulto',
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.md),

                            FilledButton.tonalIcon(
                              onPressed: () {},
                              icon: const Icon(Icons.child_care_outlined),
                              label: const Text(
                                'Registrar paciente menor de edad',
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            const Divider(),

                            const SizedBox(height: AppSpacing.lg),

                            Text(
                              '¿Ya tienes una cuenta?',
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium,
                            ),

                            const SizedBox(height: AppSpacing.sm),

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text('Ya tengo cuenta'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
