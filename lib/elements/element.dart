import 'package:flutter/widgets.dart';
import 'package:remotecontrol_lib/values/touchpad_actions.dart';

import '../actions/action_base.dart';
import '../actions/action_contexts.dart';
import '../values/geometry.dart';
import 'element_base.dart';

abstract class BaseTextElement extends BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  @override
  Widget build(BuildContext context);

  BaseTextElement({
    this.label = '',
    this.geometry = const Geometry(),
  }) : super(label);
}

/// [KeyActuationType] is the type of actuation of a key.
/// - TAP means the key is actuated when the user taps on it.
/// - PRESS means the key enters DOWN state when the user taps on it and UP
/// state when the user releases it.
enum KeyActuationType { TAP, PRESS }

abstract class BaseKeyElement extends BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  BaseAction<BaseKeyActionContext> get action;

  KeyActuationType get actuationType;
  bool get toggle;

  double get keyRep;
  double get keyRepeatDelay;

  BaseAction<BaseKeyActionContext>? get holdAction;
  double get holdTimeThreshold;

  BaseAction<BaseKeyActionContext>? get doubleTapAction;
  double get doubleTapThershold;

  const BaseKeyElement(
    BaseAction<BaseKeyActionContext> action, {
    this.label = '',
    this.geometry = const Geometry(),
  }) : super(label);

  @override
  Widget build(BuildContext context);
}

abstract class BaseTouchpadElement extends BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  TouchpadActions get actions;
  bool get scrollbar;
  bool get mouseButtons;
  bool get tapToClick;
  bool get doubleTapAndHold;

  const BaseTouchpadElement(
    TouchpadActions actions, {
    this.label = '',
    this.geometry = const Geometry(),
    bool scrollbar = true,
    bool mouseButtons = true,
    bool tapToClick = true,
    bool doubleTapAndHold = true,
  }) : super(label);

  @override
  Widget build(BuildContext context);
}

abstract class BaseButtonElement extends BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  BaseAction<BaseButtonActionContext> get action;

  const BaseButtonElement(
    BaseAction<BaseButtonActionContext> action, {
    this.label = '',
    this.geometry = const Geometry(),
  }) : super(label);

  @override
  Widget build(BuildContext context);
}
