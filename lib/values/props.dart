import 'package:flutter/widgets.dart';
import 'package:remotecontrol_lib/values/color.dart';

import '../keyboard.dart';

abstract class BaseElementProps<T> {
  final String? label;
  final Geometry? geometry;

  bool get isFilled => label != null && geometry != null;

  Geometry? geometryFrom<E extends BaseElementProps>(E other) {
    if (other.geometry != null) {
      return (geometry ?? const Geometry()).copyFrom(other.geometry!);
    } else {
      return geometry;
    }
  }

  const BaseElementProps({this.label, this.geometry});

  T copyWith({
    String? label,
    Geometry? geometry,
  });

  /// Creates a copy of this object but with the given fields replaced with the new values.
  T copyFrom(T other);
}

class KeyElementProps extends BaseElementProps<KeyElementProps> {
  @required
  final BaseAction<BaseKeyActionContext>? action;

  final bool? toggle;

  final double? keyRep;
  final double? keyRepeatDelay;

  // optional
  final BaseAction<BaseKeyActionContext>? doubleTapAction;
  // optional
  final BaseAction<BaseKeyActionContext>? holdAction;

  final String? shiftModifierLabel;
  final bool? unshiftOnRelease;

  /// The id of the modifier class that this key will activate if this key is a modifier
  final String? modifierId;
  final String? switchId;

  /// If true and this key is pressed, it will be released on a non-modifier key press
  final bool? disableOnNonModifierPressed;
  final bool? disableOnSwitchPressed;

  /// If true, the modifier will be locked on double tap. Uses [doubleTapThershold]
  final bool? lockOnDoubleTap;
  final bool? lockOnHold;

  final KeyColor? color;

  @override
  bool get isFilled {
    return super.isFilled &&
        keyRep != null &&
        keyRepeatDelay != null &&
        shiftModifierLabel != null &&
        modifierId != null &&
        switchId != null &&
        disableOnNonModifierPressed != null &&
        disableOnSwitchPressed != null &&
        lockOnDoubleTap != null &&
        lockOnHold != null &&
        action != null;
  }

  const KeyElementProps({
    String? label,
    Geometry? geometry,
    this.action,
    this.toggle,
    this.keyRep,
    this.keyRepeatDelay,
    this.doubleTapAction,
    this.holdAction,
    this.shiftModifierLabel,
    this.unshiftOnRelease,
    this.modifierId,
    this.switchId,
    this.disableOnNonModifierPressed,
    this.disableOnSwitchPressed,
    this.lockOnDoubleTap,
    this.lockOnHold,
    this.color,
  }) : super(label: label, geometry: geometry);

  const KeyElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.action,
    this.toggle = false,
    this.keyRep = 0.0,
    this.keyRepeatDelay = 0.0,
    this.doubleTapAction,
    this.holdAction,
    this.shiftModifierLabel = '',
    this.unshiftOnRelease = false,
    this.modifierId = '',
    this.switchId = '',
    this.disableOnNonModifierPressed = false,
    this.disableOnSwitchPressed = false,
    this.lockOnDoubleTap = false,
    this.lockOnHold = false,
    this.color,
  }) : super(label: label, geometry: geometry);

  @override
  KeyElementProps copyWith({
    String? label,
    Geometry? geometry,
    BaseAction<BaseKeyActionContext>? action,
    bool? toggle,
    double? keyRep,
    double? keyRepeatDelay,
    BaseAction<BaseKeyActionContext>? doubleTapAction,
    BaseAction<BaseKeyActionContext>? holdAction,
    String? shiftModifierLabel,
    bool? unshiftOnRelease,
    String? modifierId,
    String? switchId,
    bool? disableOnNonModifierPressed,
    bool? disableOnSwitchPressed,
    bool? lockOnDoubleTap,
    bool? lockOnHold,
    KeyColor? color,
  }) {
    return KeyElementProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
      action: action ?? this.action,
      toggle: toggle ?? this.toggle,
      keyRep: keyRep ?? this.keyRep,
      keyRepeatDelay: keyRepeatDelay ?? this.keyRepeatDelay,
      doubleTapAction: doubleTapAction ?? this.doubleTapAction,
      holdAction: holdAction ?? this.holdAction,
      shiftModifierLabel: shiftModifierLabel ?? this.shiftModifierLabel,
      unshiftOnRelease: unshiftOnRelease ?? this.unshiftOnRelease,
      modifierId: modifierId ?? this.modifierId,
      switchId: switchId ?? this.switchId,
      disableOnNonModifierPressed:
          disableOnNonModifierPressed ?? this.disableOnNonModifierPressed,
      disableOnSwitchPressed: disableOnSwitchPressed ?? this.disableOnSwitchPressed,
      lockOnDoubleTap: lockOnDoubleTap ?? this.lockOnDoubleTap,
      lockOnHold: lockOnHold ?? this.lockOnHold,
      color: color ?? this.color,
    );
  }

  @override
  KeyElementProps copyFrom(KeyElementProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
      action: other.action,
      toggle: other.toggle,
      keyRep: other.keyRep,
      keyRepeatDelay: other.keyRepeatDelay,
      doubleTapAction: other.doubleTapAction,
      holdAction: other.holdAction,
      shiftModifierLabel: other.shiftModifierLabel,
      unshiftOnRelease: other.unshiftOnRelease,
      modifierId: other.modifierId,
      switchId: other.switchId,
      disableOnNonModifierPressed: other.disableOnNonModifierPressed,
      disableOnSwitchPressed: other.disableOnSwitchPressed,
      lockOnDoubleTap: other.lockOnDoubleTap,
      lockOnHold: other.lockOnHold,
      color: other.color,
    );
  }

  //T copyFrom<T extends BaseElementProps>(T other);
}

class TapElementProps extends BaseElementProps<TapElementProps> {
  @required
  final BaseAction<BaseKeyActionContext>? action;

  final bool? toggle;

  // optional
  final BaseAction<BaseKeyActionContext>? doubleTapAction;
  // optional
  final BaseAction<BaseKeyActionContext>? holdAction;

  final String? shiftModifierLabel;
  final bool? unshiftOnRelease;

  /// The id of the modifier class that this key will activate if this key is a modifier
  final String? modifierId;
  final String? switchId;

  /// If true and this key is pressed, it will be released on a non-modifier key press
  final bool? disableOnNonModifierPressed;
  final bool? disableOnSwitchPressed;

  /// If true, the modifier will be locked on double tap. Uses [doubleTapThershold]
  final bool? lockOnDoubleTap;
  final bool? lockOnHold;

  final KeyColor? color;

  @override
  bool get isFilled {
    return super.isFilled &&
        shiftModifierLabel != null &&
        modifierId != null &&
        switchId != null &&
        disableOnNonModifierPressed != null &&
        disableOnSwitchPressed != null &&
        lockOnDoubleTap != null &&
        lockOnHold != null &&
        action != null;
  }

  const TapElementProps({
    String? label,
    Geometry? geometry,
    this.action,
    this.toggle,
    this.doubleTapAction,
    this.holdAction,
    this.shiftModifierLabel,
    this.unshiftOnRelease,
    this.modifierId,
    this.switchId,
    this.disableOnNonModifierPressed,
    this.disableOnSwitchPressed,
    this.lockOnDoubleTap,
    this.lockOnHold,
    this.color,
  }) : super(label: label, geometry: geometry);

  const TapElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.action,
    this.toggle = false,
    this.doubleTapAction,
    this.holdAction,
    this.shiftModifierLabel = '',
    this.unshiftOnRelease = false,
    this.modifierId = '',
    this.switchId = '',
    this.disableOnNonModifierPressed = false,
    this.disableOnSwitchPressed = false,
    this.lockOnDoubleTap = false,
    this.lockOnHold = false,
    this.color,
  }) : super(label: label, geometry: geometry);

  @override
  TapElementProps copyWith({
    String? label,
    Geometry? geometry,
    BaseAction<BaseKeyActionContext>? action,
    bool? toggle,
    BaseAction<BaseKeyActionContext>? doubleTapAction,
    BaseAction<BaseKeyActionContext>? holdAction,
    String? shiftModifierLabel,
    bool? unshiftOnRelease,
    String? modifierId,
    String? switchId,
    bool? disableOnNonModifierPressed,
    bool? disableOnSwitchPressed,
    bool? lockOnDoubleTap,
    bool? lockOnHold,
    KeyColor? color,
  }) {
    return TapElementProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
      action: action ?? this.action,
      toggle: toggle ?? this.toggle,
      doubleTapAction: doubleTapAction ?? this.doubleTapAction,
      holdAction: holdAction ?? this.holdAction,
      shiftModifierLabel: shiftModifierLabel ?? this.shiftModifierLabel,
      unshiftOnRelease: unshiftOnRelease ?? this.unshiftOnRelease,
      modifierId: modifierId ?? this.modifierId,
      switchId: switchId ?? this.switchId,
      disableOnNonModifierPressed:
          disableOnNonModifierPressed ?? this.disableOnNonModifierPressed,
      disableOnSwitchPressed: disableOnSwitchPressed ?? this.disableOnSwitchPressed,
      lockOnDoubleTap: lockOnDoubleTap ?? this.lockOnDoubleTap,
      lockOnHold: lockOnHold ?? this.lockOnHold,
      color: color ?? this.color,
    );
  }

  @override
  TapElementProps copyFrom(TapElementProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
      action: other.action,
      toggle: other.toggle,
      doubleTapAction: other.doubleTapAction,
      holdAction: other.holdAction,
      shiftModifierLabel: other.shiftModifierLabel,
      unshiftOnRelease: other.unshiftOnRelease,
      modifierId: other.modifierId,
      switchId: other.switchId,
      disableOnNonModifierPressed: other.disableOnNonModifierPressed,
      disableOnSwitchPressed: other.disableOnSwitchPressed,
      lockOnDoubleTap: other.lockOnDoubleTap,
      lockOnHold: other.lockOnHold,
      color: other.color,
    );
  }
}

class HotkeyElementProps extends BaseElementProps<HotkeyElementProps> {
  @required
  final BaseAction<BaseHotkeyActionContext>? action;

  final KeyActuationType? actuationType;

  final bool? toggle;

  final double? keyRep;
  final double? keyRepeatDelay;

  final String? shiftModifierLabel;

  final KeyColor? color;

  @override
  bool get isFilled {
    return super.isFilled &&
        actuationType != null &&
        toggle != null &&
        keyRep != null &&
        keyRepeatDelay != null &&
        shiftModifierLabel != null &&
        action != null;
  }

  const HotkeyElementProps({
    String? label,
    Geometry? geometry,
    this.action,
    this.actuationType,
    this.toggle,
    this.keyRep,
    this.keyRepeatDelay,
    this.shiftModifierLabel,
    this.color,
  }) : super(label: label, geometry: geometry);

  const HotkeyElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.action,
    this.actuationType = KeyActuationType.PRESS,
    this.toggle = false,
    this.keyRep = 0.0,
    this.keyRepeatDelay = 0.0,
    this.shiftModifierLabel = '',
    this.color,
  }) : super(label: label, geometry: geometry);

  @override
  HotkeyElementProps copyWith({
    String? label,
    Geometry? geometry,
    BaseAction<BaseHotkeyActionContext>? action,
    KeyActuationType? actuationType,
    bool? toggle,
    double? keyRep,
    double? keyRepeatDelay,
    String? shiftModifierLabel,
    KeyColor? color,
  }) {
    return HotkeyElementProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
      action: action ?? this.action,
      actuationType: actuationType ?? this.actuationType,
      toggle: toggle ?? this.toggle,
      keyRep: keyRep ?? this.keyRep,
      keyRepeatDelay: keyRepeatDelay ?? this.keyRepeatDelay,
      shiftModifierLabel: shiftModifierLabel ?? this.shiftModifierLabel,
      color: color ?? this.color,
    );
  }

  @override
  HotkeyElementProps copyFrom(HotkeyElementProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
      action: other.action,
      actuationType: other.actuationType,
      toggle: other.toggle,
      keyRep: other.keyRep,
      keyRepeatDelay: other.keyRepeatDelay,
      shiftModifierLabel: other.shiftModifierLabel,
      color: other.color,
    );
  }
}

class ToggleElementProps extends BaseElementProps<ToggleElementProps> {
  @required
  final String? switchId;
  @required
  final BaseAction<BaseToggleActionContext>? action;

  final KeyActuationType? actuationType;

  final bool? toggle;

  final String? shiftModifierLabel;

  /// If true and this toggle is toggled, it will be untoggled on a non-modifier key press
  final bool? untoggleOnNonModifierKeyPressed;

  /// If true, the toggle will be locked on double tap
  final bool? lockOnDoubleTap;
  final bool? lockOnHold;

  final KeyColor? color;

  @override
  bool get isFilled {
    return super.isFilled &&
        switchId != null &&
        actuationType != null &&
        toggle != null &&
        shiftModifierLabel != null &&
        untoggleOnNonModifierKeyPressed != null &&
        lockOnDoubleTap != null &&
        lockOnHold != null &&
        action != null;
  }

  const ToggleElementProps({
    String? label,
    Geometry? geometry,
    this.switchId,
    this.action,
    this.actuationType,
    this.toggle,
    this.shiftModifierLabel,
    this.untoggleOnNonModifierKeyPressed,
    this.lockOnDoubleTap,
    this.lockOnHold,
    this.color,
  }) : super(label: label, geometry: geometry);

  const ToggleElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.switchId,
    this.action,
    this.actuationType = KeyActuationType.PRESS,
    this.toggle = false,
    this.shiftModifierLabel = '',
    this.untoggleOnNonModifierKeyPressed = false,
    this.lockOnDoubleTap = false,
    this.lockOnHold = false,
    this.color,
  }) : super(label: label, geometry: geometry);

  @override
  ToggleElementProps copyWith({
    String? label,
    Geometry? geometry,
    String? switchId,
    BaseAction<BaseToggleActionContext>? action,
    KeyActuationType? actuationType,
    bool? toggle,
    String? shiftModifierLabel,
    bool? untoggleOnNonModifierKeyPressed,
    bool? lockOnDoubleTap,
    bool? lockOnHold,
    KeyColor? color,
  }) {
    return ToggleElementProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
      switchId: switchId ?? this.switchId,
      action: action ?? this.action,
      actuationType: actuationType ?? this.actuationType,
      toggle: toggle ?? this.toggle,
      shiftModifierLabel: shiftModifierLabel ?? this.shiftModifierLabel,
      untoggleOnNonModifierKeyPressed:
          untoggleOnNonModifierKeyPressed ?? this.untoggleOnNonModifierKeyPressed,
      lockOnDoubleTap: lockOnDoubleTap ?? this.lockOnDoubleTap,
      lockOnHold: lockOnHold ?? this.lockOnHold,
      color: color ?? this.color,
    );
  }

  @override
  ToggleElementProps copyFrom(ToggleElementProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
      switchId: other.switchId,
      action: other.action,
      actuationType: other.actuationType,
      toggle: other.toggle,
      shiftModifierLabel: other.shiftModifierLabel,
      untoggleOnNonModifierKeyPressed: other.untoggleOnNonModifierKeyPressed,
      lockOnDoubleTap: other.lockOnDoubleTap,
      lockOnHold: other.lockOnHold,
      color: other.color,
    );
  }
}

class ButtonElementProps extends BaseElementProps<ButtonElementProps> {
  final BaseAction<BaseButtonActionContext>? action;

  final KeyColor? color;

  const ButtonElementProps({String? label, Geometry? geometry, this.action, this.color})
      : super(label: label, geometry: geometry);

  const ButtonElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.action,
    this.color,
  }) : super(label: label, geometry: geometry);

  @override
  ButtonElementProps copyWith({
    String? label,
    Geometry? geometry,
    BaseAction<BaseButtonActionContext>? action,
    KeyColor? color,
  }) {
    return ButtonElementProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
      action: action ?? this.action,
      color: color ?? this.color,
    );
  }

  @override
  ButtonElementProps copyFrom(ButtonElementProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
      action: other.action,
      color: other.color,
    );
  }
}

class TextElementProps extends BaseElementProps<TextElementProps> {
  const TextElementProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);

  const TextElementProps.filled({
    required String label,
    Geometry geometry = const Geometry(),
  }) : super(label: label, geometry: geometry);

  @override
  TextElementProps copyWith({
    String? label,
    Geometry? geometry,
  }) {
    return TextElementProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
    );
  }

  @override
  TextElementProps copyFrom(TextElementProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
    );
  }
}

class TouchpadElementProps extends BaseElementProps<TouchpadElementProps> {
  @required
  final TouchpadActions? actions;

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
    this.actions,
    this.scrollbar,
    this.mouseButtons,
    this.tapToClick,
    this.doubleTapAndHold,
  }) : super(label: label, geometry: geometry);

  const TouchpadElementProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
    this.actions,
    this.scrollbar = false,
    this.mouseButtons = false,
    this.tapToClick = false,
    this.doubleTapAndHold = false,
  }) : super(label: label, geometry: geometry);

  @override
  TouchpadElementProps copyWith({
    String? label,
    Geometry? geometry,
    TouchpadActions? actions,
    bool? scrollbar,
    bool? mouseButtons,
    bool? tapToClick,
    bool? doubleTapAndHold,
  }) {
    return TouchpadElementProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
      actions: actions ?? this.actions,
      scrollbar: scrollbar ?? this.scrollbar,
      mouseButtons: mouseButtons ?? this.mouseButtons,
      tapToClick: tapToClick ?? this.tapToClick,
      doubleTapAndHold: doubleTapAndHold ?? this.doubleTapAndHold,
    );
  }

  @override
  TouchpadElementProps copyFrom(TouchpadElementProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
      actions: other.actions,
      scrollbar: other.scrollbar,
      mouseButtons: other.mouseButtons,
      tapToClick: other.tapToClick,
      doubleTapAndHold: other.doubleTapAndHold,
    );
  }
}

class FlexLayoutProps extends BaseElementProps<FlexLayoutProps> {
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

  @override
  FlexLayoutProps copyWith({
    String? label,
    Geometry? geometry,
    Direction? direction,
    double? columnGap,
    double? rowGap,
    bool? expandChildren,
  }) {
    return FlexLayoutProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
      direction: direction ?? this.direction,
      columnGap: columnGap ?? this.columnGap,
      rowGap: rowGap ?? this.rowGap,
      expandChildren: expandChildren ?? this.expandChildren,
    );
  }

  @override
  FlexLayoutProps copyFrom(FlexLayoutProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
      direction: other.direction,
      columnGap: other.columnGap,
      rowGap: other.rowGap,
      expandChildren: other.expandChildren,
    );
  }
}

class RowLayoutProps extends BaseElementProps<RowLayoutProps> {
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

  @override
  RowLayoutProps copyWith({
    String? label,
    Geometry? geometry,
    double? columnGap,
    bool? expandChildren,
  }) {
    return RowLayoutProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
      columnGap: columnGap ?? this.columnGap,
      expandChildren: expandChildren ?? this.expandChildren,
    );
  }

  @override
  RowLayoutProps copyFrom(RowLayoutProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
      columnGap: other.columnGap,
      expandChildren: other.expandChildren,
    );
  }
}

class ColumnLayoutProps extends BaseElementProps<ColumnLayoutProps> {
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

  @override
  ColumnLayoutProps copyWith({
    String? label,
    Geometry? geometry,
    double? rowGap,
    bool? expandChildren,
  }) {
    return ColumnLayoutProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
      rowGap: rowGap ?? this.rowGap,
      expandChildren: expandChildren ?? this.expandChildren,
    );
  }

  @override
  ColumnLayoutProps copyFrom(ColumnLayoutProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
      rowGap: other.rowGap,
      expandChildren: other.expandChildren,
    );
  }
}

class HorizontalSpacerProps extends BaseElementProps<HorizontalSpacerProps> {
  const HorizontalSpacerProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);

  const HorizontalSpacerProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
  }) : super(label: label, geometry: geometry);

  @override
  HorizontalSpacerProps copyWith({
    String? label,
    Geometry? geometry,
  }) {
    return HorizontalSpacerProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
    );
  }

  @override
  HorizontalSpacerProps copyFrom(HorizontalSpacerProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
    );
  }
}

class VerticalSpacerProps extends BaseElementProps<VerticalSpacerProps> {
  const VerticalSpacerProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);

  const VerticalSpacerProps.filled({
    String label = '',
    Geometry geometry = const Geometry(),
  }) : super(label: label, geometry: geometry);

  @override
  VerticalSpacerProps copyWith({
    String? label,
    Geometry? geometry,
  }) {
    return VerticalSpacerProps(
      label: label ?? this.label,
      geometry: geometry ?? this.geometry,
    );
  }

  @override
  VerticalSpacerProps copyFrom(VerticalSpacerProps other) {
    return copyWith(
      label: other.label,
      geometry: geometryFrom(other),
    );
  }
}
