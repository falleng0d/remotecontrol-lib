import 'package:flutter/widgets.dart';
import 'package:remotecontrol_lib/elements/element.dart';
import 'package:remotecontrol_lib/widgets.dart' as widget;

import '../components/cross_expanded.dart';
import '../values/direction.dart';
import '../values/geometry.dart';

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
  final List<BaseElement> children;

  final Direction direction;
  final double columnGap;
  final double rowGap;

  final bool expandChildren;

  FlexLayout({
    String label = '',
    this.geometry = const Geometry(),
    this.direction = Direction.Row,
    this.columnGap = 0,
    this.rowGap = 0,
    this.expandChildren = false,
    required this.children,
  }) : super(label);

  Widget _addWrapper(List<Widget> children) {
    if (direction == Direction.Row) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      );
    }
  }

  Widget _addExpand(Widget widget) {
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
  }

  Widget _addContainer(Widget widget) {
    return !geometry.isEmpty()
        ? Container(
            padding: geometry.padding ?? const EdgeInsets.all(0),
            margin: geometry.margin ?? const EdgeInsets.all(0),
            width: geometry.width,
            height: geometry.height,
            constraints: BoxConstraints(
              maxWidth: geometry.maxWidth ?? double.infinity,
              maxHeight: geometry.maxHeight ?? double.infinity,
              minHeight: geometry.minHeight ?? 0,
              minWidth: geometry.minWidth ?? 0,
            ),
            child: widget,
          )
        : widget;
  }

  Widget _addExpandToChildren(Widget widget) {
    if (expandChildren == true) {
      return CrossExpanded(child: widget);
    } else {
      return widget;
    }
  }

  Widget _transformChildren(Widget widget) {
    widget = _addExpandToChildren(widget);
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    assemble(List<Widget> children) {
      Widget widget;
      widget = children.length > 1 ? _addWrapper(children) : children[0];
      widget = _addExpand(_addContainer(widget));
      return widget;
    }

    final visibleChildren = children.where((element) => element.isVisible == true);

    return widget.FlexLayout(
      children: assemble(
        visibleChildren.map((e) => _transformChildren(e.build(context))).toList(),
      ),
    );
  }
}

class RowLayout extends FlexLayout {
  RowLayout({
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
  ColumnLayout({
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
  bool isVisible = true;

  HorizontalSpacer({
    String label = '',
    this.geometry = const Geometry(),
  }) : super(label);

  @override
  Widget build(BuildContext context) {
    return widget.HorizontalSpacer(geometry: geometry);
  }

  @override
  void onHide() {}

  @override
  void onShow() {}
}

class VerticalSpacer extends BaseElement {
  @override
  final Geometry geometry;
  @override
  bool isVisible = true;

  VerticalSpacer({
    String label = '',
    this.geometry = const Geometry(),
  }) : super(label);

  @override
  Widget build(BuildContext context) {
    return widget.VerticalSpacer(geometry: geometry);
  }

  @override
  void onHide() {}

  @override
  void onShow() {}
}

/// [VisibilityElement] is a layout element that can be used to hide or show
/// a child element.
///
/// Its display property is controlled by a [Switch]
class VisibilityElement extends BaseElement {
  @override
  final Geometry geometry = const Geometry();
  final BaseElement child;

  VisibilityElement({
    String label = '',
    bool display = true,
    required this.child,
  }) : super(label) {
    this.display = display;
  }

  @override
  Widget build(BuildContext context) => child.build(context);

  @override
  void dispose() => child.dispose();

  @override
  void init() => child.init();

  @override
  void onHide() => child.visible = false;

  @override
  void onShow() => child.visible = true;
}
