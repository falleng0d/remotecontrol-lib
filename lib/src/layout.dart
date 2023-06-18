import 'package:flutter/widgets.dart';
import '../components/CrossExpanded.dart';
import 'base.dart';

/// An abstract base class representing a layout element in the application.
/// Layout elements are displayable controls that can contain other [BaseElement] objects,
/// which are defined in the [children] property. The [geometry] property defines the
/// layout's characteristics such as width, height, expansion behavior, and padding.
///
/// Extend this class to create custom layouts using their own [BaseElement] children
/// and desired layout characteristics.
abstract class BaseLayout extends BaseElement {
  List<BaseElement> get children;

  void addChild(BaseElement child);

  const BaseLayout(Geometry geometry, String label) : super(label);
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
class FlexLayout implements BaseLayout {
  @override
  final Geometry geometry;
  @override
  final String label = '';
  @override
  final List<BaseElement> children;

  final Direction direction;
  final String description;
  final double columnGap;
  final double rowGap;

  final bool expandChildren;

  const FlexLayout(
      {this.geometry = const Geometry(),
      this.direction = Direction.Row,
      this.description = '',
      this.columnGap = 0,
      this.rowGap = 0,
      this.expandChildren = false,
      String? label,
      required this.children});

  @override
  void addChild(BaseElement child) => children.add(child);

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
      widget = addContainer(widget);
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
      widget = addExpand(widget);
      return widget;
    };

    var _children = children.map((e) => transformChildren(e.build(context))).toList();
    return assemble(_children);
  }
}

class RowLayout extends FlexLayout {
  const RowLayout(
      {Geometry geometry = const Geometry(),
      double columnGap = 0,
      bool expandChildren = false,
      String? label,
      required List<BaseElement> children})
      : super(
            geometry: geometry,
            direction: Direction.Row,
            columnGap: columnGap,
            rowGap: 0,
            expandChildren: expandChildren,
            label: label,
            children: children);
}

class ColumnLayout extends FlexLayout {
  const ColumnLayout(
      {Geometry geometry = const Geometry(),
      double rowGap = 0,
      bool expandChildren = false,
      String? label,
      required List<BaseElement> children})
      : super(
            geometry: geometry,
            direction: Direction.Column,
            columnGap: 0,
            rowGap: rowGap,
            expandChildren: expandChildren,
            label: label,
            children: children);
}

class HorizontalSpacer implements BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  const HorizontalSpacer({this.label = '', this.geometry = const Geometry()});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class VerticalSpacer implements BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  const VerticalSpacer({this.label = '', this.geometry = const Geometry()});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
