import 'package:flutter/widgets.dart';

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
