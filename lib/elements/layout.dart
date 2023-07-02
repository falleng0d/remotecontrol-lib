import 'package:flutter/widgets.dart';
import 'package:remotecontrol_lib/widgets.dart' as widget;

import '../components/CrossExpanded.dart';
import '../values/direction.dart';
import '../values/geometry.dart';
import 'element_base.dart';

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
class FlexLayout extends BaseLayout {
  @override
  final Geometry geometry;
  @override
  final String label;
  @override
  final List<BaseElement> children;

  final Direction direction;
  final double columnGap;
  final double rowGap;

  final bool expandChildren;

  const FlexLayout({
    this.label = '',
    this.geometry = const Geometry(),
    this.direction = Direction.Row,
    this.columnGap = 0,
    this.rowGap = 0,
    this.expandChildren = false,
    required this.children,
  }) : super(geometry, label);

  @override
  Widget build(BuildContext context) {
    // Build wrapper
    var addWrapper = (List<Widget> children) {
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
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: widget),
            ],
          ),
        );
      } else {
        return widget;
      }
    };

    // Build children
    var addContainer = (Widget widget) {
      return !geometry.isEmpty()
          ? Container(
              padding: geometry.padding ?? EdgeInsets.all(0),
              margin: geometry.margin ?? EdgeInsets.all(0),
              constraints: BoxConstraints(
                maxWidth: geometry.maxWidth ?? double.infinity,
                maxHeight: geometry.maxHeight ?? double.infinity,
                minHeight: geometry.minHeight ?? 0,
                minWidth: geometry.minWidth ?? 0,
              ),
              child: widget,
            )
          : widget;
    };

    var addExpandToChildren = (Widget widget) {
      if (expandChildren == true) {
        return CrossExpanded(child: widget);
      } else {
        return widget;
      }
    };

    var transformChildren = (Widget widget) {
      widget = addExpandToChildren(widget);
      return widget;
    };

    var assemble = (List<Widget> children) {
      Widget widget;
      if (children.length > 1) {
        widget = addWrapper(children);
      } else {
        widget = children[0];
      }
      widget = addExpand(addContainer(widget));
      return widget;
    };

    var _children = children.map((e) => transformChildren(e.build(context))).toList();
    return widget.FlexLayout(children: assemble(_children));
  }
}

class RowLayout extends FlexLayout {
  const RowLayout({
    String label = '',
    Geometry geometry = const Geometry(),
    double columnGap = 0,
    bool expandChildren = false,
    required List<BaseElement> children,
  }) : super(
            geometry: geometry,
            direction: Direction.Row,
            columnGap: columnGap,
            rowGap: 0,
            expandChildren: expandChildren,
            label: label,
            children: children);
}

class ColumnLayout extends FlexLayout {
  const ColumnLayout({
    String label = '',
    Geometry geometry = const Geometry(),
    double rowGap = 0,
    bool expandChildren = false,
    required List<BaseElement> children,
  }) : super(
            geometry: geometry,
            direction: Direction.Column,
            columnGap: 0,
            rowGap: rowGap,
            expandChildren: expandChildren,
            label: label,
            children: children);
}

class HorizontalSpacer extends BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  const HorizontalSpacer({
    this.label = '',
    this.geometry = const Geometry(),
  }) : super(label);

  @override
  Widget build(BuildContext context) {
    return widget.HorizontalSpacer(geometry: geometry);
  }
}

class VerticalSpacer extends BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  const VerticalSpacer({
    this.label = '',
    this.geometry = const Geometry(),
  }) : super(label);

  @override
  Widget build(BuildContext context) {
    return widget.VerticalSpacer(geometry: geometry);
  }
}
