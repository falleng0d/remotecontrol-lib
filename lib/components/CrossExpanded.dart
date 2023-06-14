import 'package:flutter/widgets.dart';

/// Stretches a [child] widget across the main axis by wrapping it with an [Expanded]
/// widget inside a CrossAxisAlignment.stretch [Row], stretching it
class CrossExpanded extends StatelessWidget {
  final Widget child;

  const CrossExpanded({Key? key, required this.child}) : super(key: key);

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
