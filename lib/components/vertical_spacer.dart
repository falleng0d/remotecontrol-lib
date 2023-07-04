import 'package:flutter/widgets.dart';

import '../values/geometry.dart';

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({
    super.key,
    required this.geometry,
  });

  final Geometry geometry;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: geometry.flex ?? 1,
      child: const SizedBox(),
    );
  }
}
