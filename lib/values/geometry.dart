import 'package:flutter/rendering.dart';

class EdgeData {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  const EdgeData({this.left, this.top, this.right, this.bottom});

  bool isEmpty() {
    return left == null && top == null && right == null && bottom == null;
  }

  factory EdgeData.fromMap(Map<String, dynamic> map) {
    return EdgeData(
        left: map['left'], top: map['top'], right: map['right'], bottom: map['bottom']);
  }

  factory EdgeData.only({double? left, double? top, double? right, double? bottom}) {
    return EdgeData(left: left, top: top, right: right, bottom: bottom);
  }

  factory EdgeData.all(double value) {
    return EdgeData(left: value, top: value, right: value, bottom: value);
  }

  factory EdgeData.symmetric({double? horizontal, double? vertical}) {
    return EdgeData(left: horizontal, top: vertical, right: horizontal, bottom: vertical);
  }

  factory EdgeData.fromLTRB(double? left, double? top, double? right, double? bottom) {
    return EdgeData(left: left, top: top, right: right, bottom: bottom);
  }

  factory EdgeData.zero() {
    return const EdgeData(left: 0, top: 0, right: 0, bottom: 0);
  }

  EdgeData copyWith({double? left, double? top, double? right, double? bottom}) {
    return EdgeData(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }

  EdgeData copyFrom(EdgeData other) {
    return EdgeData(
      left: other.left ?? left,
      top: other.top ?? top,
      right: other.right ?? right,
      bottom: other.bottom ?? bottom,
    );
  }

  EdgeData copy() {
    return EdgeData(left: left, top: top, right: right, bottom: bottom);
  }

  EdgeInsets toEdgeInsets() {
    return EdgeInsets.only(
        left: left ?? 0, top: top ?? 0, right: right ?? 0, bottom: bottom ?? 0);
  }
}

class Geometry {
  final double? width;
  final double? height;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;

  final bool? expand;
  final int? flex;
  final EdgeData? padding;
  final EdgeData? margin;

  /// border corner radius for each corner
  final BorderRadius? borderRadius;

  bool isEmpty({bool includeExpand = true, bool includeFlex = true}) {
    return width == null &&
        height == null &&
        minWidth == null &&
        maxWidth == null &&
        minHeight == null &&
        maxHeight == null &&
        (includeExpand ? expand == null : true) &&
        (includeFlex ? flex == null : true) &&
        (padding == null || padding!.isEmpty()) &&
        (margin == null || margin!.isEmpty()) &&
        (borderRadius == null ||
            (borderRadius!.bottomLeft == Radius.zero &&
                borderRadius!.bottomRight == Radius.zero &&
                borderRadius!.topLeft == Radius.zero &&
                borderRadius!.topRight == Radius.zero));
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
    this.borderRadius,
  });

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      width: map['width'],
      height: map['height'],
      minWidth: map['minWidth'],
      maxWidth: map['maxWidth'],
      minHeight: map['minHeight'],
      maxHeight: map['maxHeight'],
      expand: map['expand'],
      flex: map['flex'],
      padding: map['padding'],
      margin: map['margin'],
      borderRadius: map['borderRadius'],
    );
  }

  Geometry copyWith({
    double? width,
    double? height,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    bool? expand,
    int? flex,
    EdgeData? padding,
    EdgeData? margin,
    BorderRadius? borderRadius,
  }) {
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
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
    );
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
      padding: padding != null
          ? other.padding != null
              ? padding!.copyFrom(other.padding!)
              : padding
          : null,
      margin: margin != null
          ? other.margin != null
              ? margin!.copyFrom(other.margin!)
              : margin
          : null,
      borderRadius: other.borderRadius ?? borderRadius,
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
      borderRadius: borderRadius,
    );
  }

  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('minWidth', minWidth));
    properties.add(DoubleProperty('maxWidth', maxWidth));
    properties.add(DoubleProperty('minHeight', minHeight));
    properties.add(DoubleProperty('maxHeight', maxHeight));
    properties.add(FlagProperty('expand', value: expand, ifTrue: 'expand'));
    properties.add(IntProperty('flex', flex));
    properties.add(DiagnosticsProperty<EdgeData>('padding', padding));
    properties.add(DiagnosticsProperty<EdgeData>('margin', margin));
    properties.add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius));
  }
}
