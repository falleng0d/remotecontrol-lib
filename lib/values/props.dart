import 'package:remotecontrol_lib/values/color.dart';

import '../keyboard.dart';

abstract class BaseElementProps {
  final String? label;
  final Geometry? geometry;

  bool get isFilled => label != null && geometry != null;

  Geometry? geometryFrom<T extends BaseElementProps>(T other) {
    if (other.geometry != null) {
      return (geometry ?? const Geometry()).copyFrom(other.geometry!);
    } else {
      return geometry;
    }
  }

  const BaseElementProps({this.label, this.geometry});
}

class KeyElementProps extends BaseElementProps {
  final KeyActuationType? actuationType;

  final bool? toggle;

  final double? keyRep;
  final double? keyRepeatDelay;

  final double? holdTimeThreshold;
  final double? doubleTapThershold;

  // optional
  final BaseAction<BaseKeyActionContext>? doubleTapAction;
  // optional
  final BaseAction<BaseKeyActionContext>? holdAction;

  final String? shiftModifierLabel;

  /// The id of the modifier class that this key will activate if this key is a modifier
  final String? modifierId;

  /// If true and this key is pressedm, it will be released on a non-modifier key press
  final bool? disableOnNonModifierPressed;
  final bool? disableOnSwitchPressed;

  /// If true, the modifier will be locked on double tap. Uses [doubleTapThershold]
  final bool? lockOnDoubleTap;
  final bool? lockOnHold;

  final KeyColor? color;

  @override
  bool get isFilled {
    return super.isFilled &&
        actuationType != null &&
        keyRep != null &&
        keyRepeatDelay != null &&
        holdTimeThreshold != null &&
        doubleTapThershold != null &&
        shiftModifierLabel != null &&
        modifierId != null &&
        disableOnNonModifierPressed != null &&
        disableOnSwitchPressed != null &&
        lockOnDoubleTap != null &&
        lockOnHold != null;
  }

  const KeyElementProps({
    String? label,
    Geometry? geometry,
    this.actuationType,
    this.toggle = false,
    this.keyRep,
    this.keyRepeatDelay,
    this.holdTimeThreshold,
    this.doubleTapThershold,
    this.doubleTapAction,
    this.holdAction,
    this.shiftModifierLabel,
    this.modifierId,
    this.disableOnNonModifierPressed,
    this.disableOnSwitchPressed,
    this.lockOnDoubleTap,
    this.lockOnHold,
    this.color,
  }) : super(label: label, geometry: geometry);

  const KeyElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.actuationType = KeyActuationType.PRESS,
    this.toggle = false,
    this.keyRep = 0.0,
    this.keyRepeatDelay = 0.0,
    this.holdTimeThreshold = 0.0,
    this.doubleTapAction,
    this.holdAction,
    this.doubleTapThershold = 0.0,
    this.shiftModifierLabel = '',
    this.modifierId = '',
    this.disableOnNonModifierPressed = false,
    this.disableOnSwitchPressed = false,
    this.lockOnDoubleTap = false,
    this.lockOnHold = false,
    this.color,
  }) : super(label: label, geometry: geometry);

  KeyElementProps copyFrom(KeyElementProps other) {
    return KeyElementProps(
      label: other.label ?? label,
      geometry: geometryFrom(other),
      actuationType: other.actuationType ?? actuationType,
      toggle: other.toggle ?? toggle,
      keyRep: other.keyRep ?? keyRep,
      keyRepeatDelay: other.keyRepeatDelay ?? keyRepeatDelay,
      holdTimeThreshold: other.holdTimeThreshold ?? holdTimeThreshold,
      doubleTapThershold: other.doubleTapThershold ?? doubleTapThershold,
      doubleTapAction: other.doubleTapAction ?? doubleTapAction,
      holdAction: other.holdAction ?? holdAction,
      shiftModifierLabel: other.shiftModifierLabel ?? shiftModifierLabel,
      modifierId: other.modifierId ?? modifierId,
      disableOnNonModifierPressed:
          other.disableOnNonModifierPressed ?? disableOnNonModifierPressed,
      disableOnSwitchPressed: other.disableOnSwitchPressed ?? disableOnSwitchPressed,
      lockOnDoubleTap: other.lockOnDoubleTap ?? lockOnDoubleTap,
      lockOnHold: other.lockOnHold ?? lockOnHold,
      color: other.color ?? color,
    );
  }
}

class MouseElementProps extends BaseElementProps {
  const MouseElementProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);

  const MouseElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
  }) : super(label: label, geometry: geometry);

  MouseElementProps copyFrom(MouseElementProps other) {
    return MouseElementProps(
      label: other.label ?? label,
      geometry: geometryFrom(other),
    );
  }
}

class TextElementProps extends BaseElementProps {
  const TextElementProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);

  const TextElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
  }) : super(label: label, geometry: geometry);

  TextElementProps copyFrom(TextElementProps other) {
    return TextElementProps(
      label: other.label ?? label,
      geometry: geometryFrom(other),
    );
  }
}

class TouchpadElementProps extends BaseElementProps {
  final bool? scrollbar;
  final bool? mouseButtons;
  final bool? tapToClick;
  final bool? doubleTapAndHold;

  @override
  bool get isFilled {
    return super.isFilled &&
        scrollbar != null &&
        mouseButtons != null &&
        tapToClick != null &&
        doubleTapAndHold != null;
  }

  const TouchpadElementProps({
    String? label,
    Geometry? geometry,
    this.scrollbar,
    this.mouseButtons,
    this.tapToClick,
    this.doubleTapAndHold,
  }) : super(label: label, geometry: geometry);

  const TouchpadElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.scrollbar = false,
    this.mouseButtons = false,
    this.tapToClick = false,
    this.doubleTapAndHold = false,
  }) : super(label: label, geometry: geometry);

  TouchpadElementProps copyFrom(TouchpadElementProps other) {
    return TouchpadElementProps(
      label: other.label ?? label,
      geometry: geometryFrom(other),
      scrollbar: other.scrollbar ?? scrollbar,
      mouseButtons: other.mouseButtons ?? mouseButtons,
      tapToClick: other.tapToClick ?? tapToClick,
      doubleTapAndHold: other.doubleTapAndHold ?? doubleTapAndHold,
    );
  }
}

class FlexLayoutProps extends BaseElementProps {
  final Direction? direction;
  final double? columnGap;
  final double? rowGap;
  final bool? expandChildren;

  @override
  bool get isFilled {
    return super.isFilled &&
        direction != null &&
        columnGap != null &&
        rowGap != null &&
        expandChildren != null;
  }

  const FlexLayoutProps({
    String? label,
    Geometry? geometry,
    this.direction,
    this.columnGap,
    this.rowGap,
    this.expandChildren,
  }) : super(label: label, geometry: geometry);

  const FlexLayoutProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.direction = Direction.Row,
    this.columnGap = 0.0,
    this.rowGap = 0.0,
    this.expandChildren = false,
  }) : super(label: label, geometry: geometry);

  FlexLayoutProps copyFrom(FlexLayoutProps other) {
    return FlexLayoutProps(
      label: other.label ?? label,
      geometry: geometryFrom(other),
      direction: other.direction ?? direction,
      columnGap: other.columnGap ?? columnGap,
      rowGap: other.rowGap ?? rowGap,
      expandChildren: other.expandChildren ?? expandChildren,
    );
  }
}

class RowLayoutProps extends BaseElementProps {
  final double? columnGap;
  final bool? expandChildren;

  @override
  bool get isFilled {
    return super.isFilled && columnGap != null && expandChildren != null;
  }

  const RowLayoutProps({
    String? label,
    Geometry? geometry,
    this.columnGap,
    this.expandChildren,
  }) : super(label: label, geometry: geometry);

  const RowLayoutProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.columnGap = 0.0,
    this.expandChildren = false,
  }) : super(label: label, geometry: geometry);

  RowLayoutProps copyFrom(RowLayoutProps other) {
    return RowLayoutProps(
      label: other.label ?? label,
      geometry: geometryFrom(other),
      columnGap: other.columnGap ?? columnGap,
      expandChildren: other.expandChildren ?? expandChildren,
    );
  }
}

class ColumnLayoutProps extends BaseElementProps {
  final double? rowGap;
  final bool? expandChildren;

  @override
  bool get isFilled {
    return super.isFilled && rowGap != null && expandChildren != null;
  }

  const ColumnLayoutProps({
    String? label,
    Geometry? geometry,
    this.rowGap,
    this.expandChildren,
  }) : super(label: label, geometry: geometry);

  const ColumnLayoutProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.rowGap = 0.0,
    this.expandChildren = false,
  }) : super(label: label, geometry: geometry);

  ColumnLayoutProps copyFrom(ColumnLayoutProps other) {
    return ColumnLayoutProps(
      label: other.label ?? label,
      geometry: geometryFrom(other),
      rowGap: other.rowGap ?? rowGap,
      expandChildren: other.expandChildren ?? expandChildren,
    );
  }
}

class HorizontalSpacerProps extends BaseElementProps {
  const HorizontalSpacerProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);

  const HorizontalSpacerProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
  }) : super(label: label, geometry: geometry);

  HorizontalSpacerProps copyFrom(HorizontalSpacerProps other) {
    return HorizontalSpacerProps(
      label: other.label ?? label,
      geometry: geometryFrom(other),
    );
  }
}

class VerticalSpacerProps extends BaseElementProps {
  const VerticalSpacerProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);

  const VerticalSpacerProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
  }) : super(label: label, geometry: geometry);

  VerticalSpacerProps copyFrom(VerticalSpacerProps other) {
    return VerticalSpacerProps(
      label: other.label ?? label,
      geometry: geometryFrom(other),
    );
  }
}
