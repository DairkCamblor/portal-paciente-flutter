import 'package:flutter/material.dart';

class PortalCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const PortalCard({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(padding: const EdgeInsets.all(18), child: child),
      ),
    );
  }
}
