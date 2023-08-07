import 'package:fluent_ui/fluent_ui.dart';

import '../values/geometry.dart';
import 'geometry.dart';

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({
    super.key,
    required this.geometry,
  });

  final Geometry geometry;

  @override
  Widget build(BuildContext context) {
    return GeometryWidget(
      geometry: geometry,
      child: const Center(),
    );
  }
}
