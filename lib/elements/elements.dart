import 'package:flutter/widgets.dart';

import 'element_base.dart';

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
  Widget build(BuildContext context);
}

abstract class BaseTapElement extends BaseElement {
  @override
  Widget build(BuildContext context);
}

abstract class BaseHotkeyElement extends BaseElement {
  @override
  Widget build(BuildContext context);
}

abstract class BaseToggleElement extends BaseElement {
  @override
  Widget build(BuildContext context);
}

abstract class BaseTouchpadElement extends BaseElement {
  @override
  Widget build(BuildContext context);
}

abstract class BaseButtonElement extends BaseElement {
  @override
  Widget build(BuildContext context);
}

abstract class BaseTextElement extends BaseElement {
  @override
  Widget build(BuildContext context);
}
