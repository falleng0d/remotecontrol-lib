import 'package:flutter/widgets.dart';

class FlexLayout extends StatelessWidget {
  final Widget children;

  const FlexLayout({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return children;
  }
}
