import 'package:flutter/widgets.dart';

/// Stretches a [child] widget across the main axis by wrapping it with an [Expanded]
/// widget inside a CrossAxisAlignment.stretch [Row], stretching it
class CrossExpanded extends StatelessWidget {
  final Widget child;

  const CrossExpanded({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: child),
        ],
      ),
    );
  }
}
