import 'package:flutter/widgets.dart';
import 'package:remotecontrol_lib/elements/element.dart';
import 'package:remotecontrol_lib/widgets.dart' as widget;

import '../components/cross_expanded.dart';
import '../values/direction.dart';
import '../values/geometry.dart';
import '../values/props.dart';

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
  final String label;
  @override
  Geometry geometry;
  @override
  final List<BaseElement> children;

  final Direction direction;
  final double columnGap;
  final double rowGap;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  final bool expandChildren;

  FlexLayout({
    this.label = '',
    this.geometry = const Geometry(),
    this.direction = Direction.Row,
    this.columnGap = 0,
    this.rowGap = 0,
    this.expandChildren = false,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
  });

  FlexLayout.fromProps(FlexLayoutProps props, List<BaseElement> children)
      : this(
          label: props.label!,
          geometry: props.geometry!,
          direction: props.direction!,
          columnGap: props.columnGap!,
          rowGap: props.rowGap!,
          expandChildren: props.expandChildren!,
          mainAxisAlignment: props.mainAxisAlignment!,
          crossAxisAlignment: props.crossAxisAlignment!,
          children: children,
        );

  Widget _addExpandToChildren(Widget widget) {
    if (expandChildren == true) {
      return CrossExpanded(child: widget);
    } else {
      return widget;
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleChildren = children.where((element) => element.isVisible == true);
    final assembledChildren =
        visibleChildren.map((e) => _addExpandToChildren(e.build(context))).toList();

    // Geometry geometry = this.geometry;
    // if (geometry.expand == true) {
    //   geometry = geometry.copyWith(expand: false);
    // }

    // First children's left margin should be 0
    // Last children's right margin should be 0
    if (direction == Direction.Row && children.isNotEmpty) {
      final firstChild = children.first;
      final lastChild = children.last;

      if (firstChild.geometry.margin != null &&
          firstChild.geometry.margin!.left != null &&
          firstChild.geometry.margin!.left! > 0) {
        firstChild.geometry = firstChild.geometry.copyWith(
          margin: firstChild.geometry.margin!.copyWith(left: 0),
        );
      }

      if (lastChild.geometry.margin != null &&
          lastChild.geometry.margin!.right != null &&
          lastChild.geometry.margin!.right! > 0) {
        lastChild.geometry = lastChild.geometry.copyWith(
          margin: lastChild.geometry.margin!.copyWith(right: 0),
        );
      }
    }

    return widget.FlexLayout(
      label: label,
      direction: direction,
      geometry: geometry,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: assembledChildren,
    );
  }
}

class RowLayout extends FlexLayout {
  RowLayout({
    String label = '',
    Geometry geometry = const Geometry(),
    double columnGap = 0,
    bool expandChildren = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    required List<BaseElement> children,
  }) : super(
            label: label,
            geometry: geometry,
            direction: Direction.Row,
            columnGap: columnGap,
            rowGap: 0,
            expandChildren: expandChildren,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children);

  RowLayout.fromProps(RowLayoutProps props, List<BaseElement> children)
      : this(
          label: props.label!,
          geometry: props.geometry!,
          columnGap: props.columnGap!,
          expandChildren: props.expandChildren!,
          mainAxisAlignment: props.mainAxisAlignment!,
          crossAxisAlignment: props.crossAxisAlignment!,
          children: children,
        );
}

class ColumnLayout extends FlexLayout {
  ColumnLayout({
    String label = '',
    Geometry geometry = const Geometry(),
    double rowGap = 0,
    bool expandChildren = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    required List<BaseElement> children,
  }) : super(
            label: label,
            geometry: geometry,
            direction: Direction.Column,
            columnGap: 0,
            rowGap: rowGap,
            expandChildren: expandChildren,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children);

  ColumnLayout.fromProps(ColumnLayoutProps props, List<BaseElement> children)
      : this(
          label: props.label!,
          geometry: props.geometry!,
          rowGap: props.rowGap!,
          expandChildren: props.expandChildren!,
          mainAxisAlignment: props.mainAxisAlignment!,
          crossAxisAlignment: props.crossAxisAlignment!,
          children: children,
        );
}

class HorizontalSpacer extends BaseElement {
  @override
  final String label;
  @override
  Geometry geometry;

  @override
  bool isVisible = true;

  HorizontalSpacer({
    this.label = '',
    this.geometry = const Geometry(),
  });

  HorizontalSpacer.fromProps(HorizontalSpacerProps props)
      : this(
          label: props.label!,
          geometry: props.geometry!,
        );

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
  final String label;
  @override
  Geometry geometry;

  @override
  bool isVisible = true;

  VerticalSpacer({
    this.label = '',
    this.geometry = const Geometry(),
  });

  VerticalSpacer.fromProps(VerticalSpacerProps props)
      : this(
          label: props.label!,
          geometry: props.geometry!,
        );

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
  final String label;
  @override
  Geometry geometry = const Geometry();

  final BaseElement child;

  VisibilityElement({
    this.label = '',
    bool display = true,
    required this.child,
  }) {
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
