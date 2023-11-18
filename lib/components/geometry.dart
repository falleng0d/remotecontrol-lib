import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:remotecontrol_lib/keyboard.dart';

class GeometryWidget extends StatelessWidget {
  final Geometry? geometry;
  final Widget child;

  const GeometryWidget({super.key, this.geometry, required this.child});

  bool hasConstraints() {
    return geometry!.maxWidth != null ||
        geometry!.maxHeight != null ||
        geometry!.minWidth != null ||
        geometry!.minHeight != null;
  }

  Widget buildGeometry(BuildContext context, Geometry geometry) {
    Widget widget = child;

    if (geometry.borderRadius != null &&
        (geometry.borderRadius!.topLeft != Radius.zero ||
            geometry.borderRadius!.topRight != Radius.zero ||
            geometry.borderRadius!.bottomLeft != Radius.zero ||
            geometry.borderRadius!.bottomRight != Radius.zero)) {
      widget = ClipRRect(
        borderRadius: geometry.borderRadius!,
        child: widget,
      );
    }

    if (geometry.padding != null && !geometry.padding!.isEmpty()) {
      widget = Padding(
        padding: geometry.padding!.toEdgeInsets(),
        child: widget,
      );
    }

    if (geometry.width != null || geometry.height != null) {
      widget = SizedBox(
        width: geometry.width,
        height: geometry.height,
        child: widget,
      );
    }

    if (geometry.maxWidth != null ||
        geometry.maxHeight != null ||
        geometry.minWidth != null ||
        geometry.minHeight != null) {
      widget = ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: geometry.maxWidth ?? double.infinity,
          maxHeight: geometry.maxHeight ?? double.infinity,
          minHeight: geometry.minHeight ?? 0,
          minWidth: geometry.minWidth ?? 0,
        ),
        child: widget,
      );
    }

    if (geometry.margin != null && !geometry.margin!.isEmpty()) {
      widget = Padding(
        padding: geometry.margin!.toEdgeInsets(),
        child: widget,
      );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    if (this.geometry == null) {
      return child;
    }

    final geometry = this.geometry!;

    Widget widget = buildGeometry(context, geometry);

    if (geometry.expand == true) {
      return Expanded(child: widget);
    } else {
      if (geometry.flex != null) {
        return Flexible(
          flex: geometry.flex!,
          fit: FlexFit.loose,
          child: widget,
        );
      }
      return widget;
    }
  }
}

class GeometricGestureDetector extends StatelessWidget {
  final Geometry? geometry;
  final Widget child;

  final bool debug;

  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;

  final GestureDoubleTapCallback? onDoubleTap;
  final GestureTapDownCallback? onDoubleTapDown;
  final GestureTapCancelCallback? onDoubleTapCancel;

  final GestureLongPressCallback? onLongPress;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressDownCallback? onLongPressDown;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapCallback? onSecondaryTap;

  const GeometricGestureDetector({
    super.key,
    this.geometry,
    this.debug = false,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onDoubleTap,
    this.onDoubleTapDown,
    this.onDoubleTapCancel,
    this.onLongPress,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.onLongPressMoveUpdate,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onSecondaryTap,
    required this.child,
  });

  bool hasConstraints() {
    return geometry!.maxWidth != null ||
        geometry!.maxHeight != null ||
        geometry!.minWidth != null ||
        geometry!.minHeight != null;
  }

  GestureDetector _buildGestureDetector(widget) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      excludeFromSemantics: true,
      onTap: onTap,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onDoubleTap: onDoubleTap,
      onDoubleTapDown: onDoubleTapDown,
      onDoubleTapCancel: onDoubleTapCancel,
      onLongPress: onLongPress,
      onLongPressUp: onLongPressUp,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onSecondaryTap: onSecondaryTap,
      child: widget,
    );
  }

  Widget buildGeometry(BuildContext context, Geometry geometry) {
    Widget widget = child;

    if (geometry.borderRadius != null &&
        (geometry.borderRadius!.topLeft != Radius.zero ||
            geometry.borderRadius!.topRight != Radius.zero ||
            geometry.borderRadius!.bottomLeft != Radius.zero ||
            geometry.borderRadius!.bottomRight != Radius.zero)) {
      widget = ClipRRect(
        borderRadius: geometry.borderRadius!,
        child: widget,
      );
    }

    if (geometry.padding != null && !geometry.padding!.isEmpty()) {
      widget = Padding(
        padding: geometry.padding!.toEdgeInsets(),
        child: widget,
      );
    }

    if (geometry.width != null || geometry.height != null) {
      widget = SizedBox(
        width: geometry.width,
        height: geometry.height,
        child: widget,
      );
    }

    if (geometry.maxWidth != null ||
        geometry.maxHeight != null ||
        geometry.minWidth != null ||
        geometry.minHeight != null) {
      widget = ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: geometry.maxWidth ?? double.infinity,
          maxHeight: geometry.maxHeight ?? double.infinity,
          minHeight: geometry.minHeight ?? 0,
          minWidth: geometry.minWidth ?? 0,
        ),
        child: widget,
      );
    }

    if (geometry.margin != null && !geometry.margin!.isEmpty()) {
      widget = Padding(
        padding: geometry.margin!.toEdgeInsets(),
        child: widget,
      );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    if (geometry == null || geometry!.isEmpty()) {
      return child;
    }

    final Widget widget;

    if (!geometry!.isEmpty()) {
      widget = _buildGestureDetector(
        buildGeometry(context, geometry!),
      );
    } else {
      widget = _buildGestureDetector(child);
    }

    if (geometry?.expand == true) {
      return Expanded(
        flex: geometry?.flex != null ? geometry!.flex! : 1,
        child: widget,
      );
    } else {
      if (geometry?.flex != null) {
        return Flexible(
          flex: geometry!.flex!,
          fit: FlexFit.tight,
          child: widget,
        );
      }
      return widget;
    }
  }
}
