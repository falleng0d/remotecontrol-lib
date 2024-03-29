import 'package:fluent_ui/fluent_ui.dart';

import '../mixins.dart';
import '../values/geometry.dart';

mixin Sizeable {
  Geometry get geometry;
  set geometry(Geometry value);
}

mixin Labeled {
  String get label;
}

abstract class AbstractElement {
  void dispose() {}

  void init() {}
}

/// A [BaseElement] is a displayable control that can be added to a [BaseLayout]
abstract class BaseElement extends AbstractElement
    with Sizeable, Labeled, Visible, Displayable {
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

  @override
  void dispose() {
    for (var element in children) {
      element.dispose();
    }
  }

  @override
  void init() {
    for (var element in children) {
      element.init();
    }
  }

  @override
  void onHide() {
    for (var element in children) {
      element.visible = false;
    }
  }

  @override
  void onShow() {
    for (var element in children) {
      element.visible = true;
    }
  }
}
