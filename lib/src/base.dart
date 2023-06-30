import 'package:fluent_ui/fluent_ui.dart';

import '../keyboard.dart';

class Geometry {
  final double? width;
  final double? height;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;

  final bool? expand;
  final int? flex;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  bool isEmpty() {
    return width == null &&
        height == null &&
        minWidth == null &&
        maxWidth == null &&
        minHeight == null &&
        maxHeight == null &&
        expand == null &&
        flex == null &&
        padding == null &&
        margin == null;
  }

  const Geometry({
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.expand,
    this.flex,
    this.padding,
    this.margin,
  });

  Geometry copyWith(
      {double? width,
      double? height,
      double? minWidth,
      double? maxWidth,
      double? minHeight,
      double? maxHeight,
      bool? expand,
      int? flex,
      EdgeInsets? padding,
      EdgeInsets? margin}) {
    assert(!(expand == false && flex != null));
    return Geometry(
        width: width ?? this.width,
        height: height ?? this.height,
        minWidth: minWidth ?? this.minWidth,
        maxWidth: maxWidth ?? this.maxWidth,
        minHeight: minHeight ?? this.minHeight,
        maxHeight: maxHeight ?? this.maxHeight,
        expand: expand ?? this.expand,
        flex: flex ?? this.flex,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin);
  }

  Geometry copyFrom(Geometry other) {
    return Geometry(
      width: other.width ?? width,
      height: other.height ?? height,
      minWidth: other.minWidth ?? minWidth,
      maxWidth: other.maxWidth ?? maxWidth,
      minHeight: other.minHeight ?? minHeight,
      maxHeight: other.maxHeight ?? maxHeight,
      expand: other.expand ?? expand,
      flex: other.flex ?? flex,
      padding: other.padding ?? padding,
      margin: other.margin ?? margin,
    );
  }

  Geometry copy() {
    return Geometry(
      width: width,
      height: height,
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
      expand: expand,
      flex: flex,
      padding: padding,
      margin: margin,
    );
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
