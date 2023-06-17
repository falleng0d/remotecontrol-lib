import 'package:flutter/widgets.dart';
import 'package:remotecontrol_lib/components/CrossExpanded.dart';

class Geometry {
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;

  final bool? expand;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  bool isEmpty() {
    return minWidth == null &&
        maxWidth == null &&
        minHeight == null &&
        maxHeight == null &&
        expand == null &&
        padding == null &&
        margin == null;
  }

  const Geometry(
      {this.minWidth,
      this.maxWidth,
      this.minHeight,
      this.maxHeight,
      this.expand,
      this.padding,
      this.margin});

  Geometry copyWith(
      {double? minWidth,
      double? maxWidth,
      double? minHeight,
      double? maxHeight,
      bool? expand,
      EdgeInsets? padding,
      EdgeInsets? margin}) {
    return Geometry(
        minWidth: minWidth ?? this.minWidth,
        maxWidth: maxWidth ?? this.maxWidth,
        minHeight: minHeight ?? this.minHeight,
        maxHeight: maxHeight ?? this.maxHeight,
        expand: expand ?? this.expand,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin);
  }

  Geometry copy() {
    return Geometry(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        expand: expand,
        padding: padding,
        margin: margin);
  }
}

mixin Sizeable {
  Geometry get geometry;
}

/// A [BaseElement] is a displayable control that can be added to a [Layout]
abstract class BaseElement with Sizeable {
  final String label;

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
  RowLayout(
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
  ColumnLayout(
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
  Geometry geometry = Geometry();

  @override
  String label = '';

  HorizontalSpacer({String? label, this.geometry = const Geometry()});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class VerticalSpacer implements BaseElement {
  @override
  Geometry geometry = Geometry();

  @override
  String label = '';

  VerticalSpacer({String? label, this.geometry = const Geometry()});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
