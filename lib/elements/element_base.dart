import 'package:fluent_ui/fluent_ui.dart';

import '../values/geometry.dart';

mixin Sizeable {
  Geometry get geometry;
}

mixin Labeled {
  String get label;
}

/// A [BaseElement] is a displayable control that can be added to a [BaseLayout]
abstract class BaseElement with Sizeable, Labeled {
  @override
  final String label;

  const BaseElement(this.label);

  Widget build(BuildContext context);
}

/// An abstract base class representing a layout element in the application.
/// Layout elements are displayable controls that can contain other [BaseElement] objects,
/// which are defined in the [children] property. The [geometry] property defines the
/// layout's characteristics such as width, height, expansion behavior, and padding.
///
/// Extend this class to create custom layouts using their own [BaseElement] children
/// and desired layout characteristics.
abstract class BaseLayout extends BaseElement {
  List<BaseElement> get children;

  const BaseLayout(Geometry geometry, String label) : super(label);
}
