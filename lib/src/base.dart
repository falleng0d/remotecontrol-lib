import 'package:fluent_ui/fluent_ui.dart';

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
