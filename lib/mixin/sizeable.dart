import 'package:flutter/rendering.dart';

import '../keyboard.dart';

extension ToEdgeData on EdgeInsets {
  EdgeData toEdgeData() {
    return EdgeData.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }
}

mixin SizeableFactory {
  late Geometry _geometry;

  Geometry get geometry => _geometry.copy();
  set geometry(Geometry geometry) => _geometry = fillGeometryEmptyWithDefaults(geometry);

  EdgeData get margin => _geometry.margin!;
  set margin(EdgeData margin) => _geometry = _geometry.copyWith(margin: margin);

  EdgeData get padding => _geometry.padding!;
  set padding(EdgeData padding) => _geometry = _geometry.copyWith(padding: padding);

  double get width => _geometry.width!;
  set width(double width) => _geometry = _geometry.copyWith(width: width);

  double get height => _geometry.height!;
  set height(double height) => _geometry = _geometry.copyWith(height: height);

  double get minWidth => _geometry.minWidth!;
  set minWidth(double minWidth) => _geometry = _geometry.copyWith(minWidth: minWidth);

  double get maxWidth => _geometry.maxWidth!;
  set maxWidth(double maxWidth) => _geometry = _geometry.copyWith(maxWidth: maxWidth);

  double get minHeight => _geometry.minHeight!;
  set minHeight(double minHeight) => _geometry = _geometry.copyWith(minHeight: minHeight);

  double get maxHeight => _geometry.maxHeight!;
  set maxHeight(double maxHeight) => _geometry = _geometry.copyWith(maxHeight: maxHeight);

  bool get expand => _geometry.expand!;
  set expand(bool expand) => _geometry = _geometry.copyWith(expand: expand);

  int get flex => _geometry.flex!;
  set flex(int flex) => _geometry = _geometry.copyWith(flex: flex);

  Geometry fillGeometryEmptyWithDefaults(Geometry geometry) {
    return geometry.copyWith(
      minWidth: geometry.minWidth ?? 10,
      maxWidth: geometry.maxWidth ?? double.infinity,
      minHeight: geometry.minHeight ?? 10,
      maxHeight: geometry.maxHeight ?? double.infinity,
      expand: geometry.expand ?? false,
      flex: geometry.flex ?? 1,
      padding: geometry.padding ?? const EdgeData(),
      margin: geometry.margin ?? const EdgeData(),
    );
  }
}
