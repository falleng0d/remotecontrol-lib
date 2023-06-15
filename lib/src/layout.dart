import 'package:flutter/widgets.dart';
import 'package:remotecontrol_lib/components/CrossExpanded.dart';

class Geometry {
  final double? maxWidth;
  final double? maxHeight;

  final bool? expand;
  final EdgeInsets? padding;

  const Geometry({this.maxWidth, this.maxHeight, this.expand, this.padding});
}

mixin Sizeable {
  Geometry get geometry;
}

/// A [BaseElement] is a displayable control that can be added to a [Layout]
abstract class BaseElement with Sizeable {
  String label;

  BaseElement(this.label);

  Widget build(BuildContext context);
}

/// An abstract base class representing a layout element in the application.
/// Layout elements are displayable controls that can contain other [BaseElement] objects,
/// which are defined in the [children] property. The [geometry] property defines the
/// layout's characteristics such as width, height, expansion behavior, and padding.
///
/// Extend this class to create custom layouts using their own [BaseElement] children
/// and desired layout characteristics.
abstract class Layout extends BaseElement {
  List<BaseElement> get children;

  Layout(Geometry geometry, String label) : super(label);
}

enum Direction { Row, Column }

/// [FlexLayout] is a customizable, flexible layout for displaying child elements,
/// child elements in can be either in a row or column direction.
///
/// This layout type provides options for expanding
/// children, applying padding, and setting custom dimensions for child elements.
/// It also allows the user to set custom gaps between rows and columns.
///
/// The layout can be configured with an optional [Geometry] object which
/// contains properties like maxWidth, maxHeight, expand, and padding that influence
/// the appearance of the layout.
class FlexLayout implements Layout {
  @override
  final Geometry geometry;

  Direction direction;
  String description;
  double columnGap;
  double rowGap;
  bool expandChildren;

  FlexLayout(
      {this.geometry = const Geometry(),
      this.direction = Direction.Row,
      this.description = '',
      this.columnGap = 0,
      this.rowGap = 0,
      this.expandChildren = false,
      String? label,
      required this.children});

  @override
  List<BaseElement> children;

  @override
  String label = '';

  @override
  Widget build(BuildContext context) {
    // Build container
    var addContainer = (List<Widget> children) {
      if (direction == Direction.Row) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );
      } else {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: children,
        );
      }
    };
    var addExpand = (Widget widget) {
      if (geometry.expand == true) {
        return CrossExpanded(child: widget);
      } else {
        return widget;
      }
    };

    // Build children
    var addPadding = (Widget widget) {
      if (geometry.padding != null) {
        return Padding(
          padding: geometry.padding!,
          child: widget,
        );
      } else {
        return widget;
      }
    };
    var addSize = (Widget widget) {
      if (geometry.maxWidth != null || geometry.maxHeight != null) {
        return SizedBox(
          width: geometry.maxWidth,
          height: geometry.maxHeight,
          child: widget,
        );
      } else {
        return widget;
      }
    };
    var addExpandToChildren = (Widget widget) {
      if (expandChildren == true) {
        return CrossExpanded(child: widget);
      } else {
        return widget;
      }
    };

    var transformChildren = (Widget widget) {
      widget = addSize(widget);
      widget = addPadding(widget);
      widget = addExpandToChildren(widget);
      return widget;
    };

    var assemble = (List<Widget> children) {
      Widget widget;
      if (children.length > 1) {
        widget = addContainer(children);
      } else {
        widget = children[0];
      }
      widget = addExpand(widget);
      return widget;
    };

    var _children = children.map((e) => transformChildren(e.build(context))).toList();
    return assemble(_children);
  }
}

class HorizontalSpacer implements BaseElement {
  @override
  Geometry geometry = Geometry();

  @override
  String label = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  HorizontalSpacer({String? label, this.geometry = const Geometry()});
}

class VerticalSpacer implements BaseElement {
  @override
  Geometry geometry = Geometry();

  @override
  String label = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  VerticalSpacer({String? label, this.geometry = const Geometry()});
}
