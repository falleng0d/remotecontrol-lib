import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../values/direction.dart';
import '../values/geometry.dart';
import 'geometry.dart';

class FlexLayout extends StatelessWidget {
  final Geometry geometry;
  final Direction direction;
  final String label;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool force;
  final List<Widget> children;

  const FlexLayout({
    super.key,
    this.label = "",
    this.geometry = const Geometry(),
    required this.direction,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.force,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (!force &&
        children.length == 1 &&
        crossAxisAlignment == CrossAxisAlignment.center) {
      widget = children[0];
    } else if (direction == Direction.Row) {
      widget = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    } else {
      widget = Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    }

    return GeometryWidget(
      geometry: geometry,
      child: widget,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label, showName: false));
    properties
        .add(EnumProperty<MainAxisAlignment>('mainAxisAlignment', mainAxisAlignment));
    properties
        .add(EnumProperty<CrossAxisAlignment>('crossAxisAlignment', crossAxisAlignment));
  }
}
