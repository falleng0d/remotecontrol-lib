import 'package:flutter/widgets.dart';

import '../action_contexts.dart';
import 'actions.dart';
import 'base.dart';

abstract class BaseTextElement implements BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  @override
  Widget build(BuildContext context);

  BaseTextElement({
    this.label = '',
    this.geometry = const Geometry(),
  });
}

abstract class BaseKeyElement implements BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  BaseAction<BaseKeyActionContext> get action;
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
  });

  @override
  Widget build(BuildContext context);
}

/// TouchAction
/// - onPanUpdate: Send mose move events to the server via a [DragUpdateDetails] object.
class TouchpadActions {
  final BaseAction? touchpadMove;
  final BaseAction? tap;
  final BaseAction? doubleTapAndHold;
  final BaseAction? releaseDoubleTapAndHold;

  const TouchpadActions({
    this.touchpadMove,
    this.tap,
    this.doubleTapAndHold,
    this.releaseDoubleTapAndHold,
  });
}

abstract class BaseTouchpadElement implements BaseElement {
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
  });

  @override
  Widget build(BuildContext context);
}

abstract class BaseButtonElement implements BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  BaseAction<BaseButtonActionContext> get action;

  const BaseButtonElement(
    BaseAction<BaseButtonActionContext> action, {
    this.label = '',
    this.geometry = const Geometry(),
  });

  @override
  Widget build(BuildContext context);
}
