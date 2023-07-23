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
  Widget build(BuildContext context);

  BaseTextElement({
    String label = '',
    this.geometry = const Geometry(),
  }) : super(label);
}

/// [KeyActuationType] is the type of actuation of a key.
/// - TAP means the key is actuated when the user taps on it.
/// - PRESS means the key enters DOWN state when the user taps on it and UP
/// state when the user releases it.
enum KeyActuationType {
  TAP('TAP'),
  PRESS('PRESS');

  const KeyActuationType(this.token);

  final String token;

  @override
  String toString() {
    return token;
  }
}

abstract class BaseKeyElement extends BaseElement {
  @override
  final Geometry geometry;

  const BaseKeyElement(
    BaseAction<BaseKeyActionContext> action, {
    String label = '',
    this.geometry = const Geometry(),
  }) : super(label);

  @override
  Widget build(BuildContext context);
}

abstract class BaseToggleElement extends BaseElement {
  @override
  final Geometry geometry;

  const BaseToggleElement(
    BaseAction<BaseToggleActionContext> action, {
    String label = '',
    this.geometry = const Geometry(),
  }) : super(label);

  @override
  Widget build(BuildContext context);
}

abstract class BaseTouchpadElement extends BaseElement {
  @override
  final Geometry geometry;

  const BaseTouchpadElement(TouchpadActions actions,
      {String label = '', this.geometry = const Geometry()})
      : super(label);

  @override
  Widget build(BuildContext context);
}

abstract class BaseButtonElement extends BaseElement {
  @override
  final Geometry geometry;

  const BaseButtonElement(
    BaseAction<BaseButtonActionContext> action, {
    String label = '',
    this.geometry = const Geometry(),
  }) : super(label);

  @override
  Widget build(BuildContext context);
}
