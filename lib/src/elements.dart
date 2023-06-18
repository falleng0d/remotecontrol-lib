import 'package:flutter/widgets.dart';

import 'actions.dart';
import 'base.dart';

abstract class BaseTextElement implements BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  @override
  Widget build(BuildContext context);

  BaseTextElement({this.geometry = const Geometry(), this.label = ''});
}

abstract class BaseKeyElement implements BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  BaseAction get action;
  bool get toggle;
  double get keyRep;
  double get keyRepeatDelay;

  BaseAction? get holdAction;
  double get holdTimeThreshold;

  BaseAction? get doubleTapAction;
  double get doubleTapThershold;

  const BaseKeyElement(BaseAction action,
      {this.geometry = const Geometry(), this.label = ''});

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
    this.geometry = const Geometry(),
    this.label = '',
    bool scrollbar = true,
    bool mouseButtons = true,
    bool tapToClick = true,
    bool doubleTapAndHold = true,
  });

  @override
  Widget build(BuildContext context);
}

abstract class BaseMouseButtonElement implements BaseElement {
  @override
  final Geometry geometry;
  @override
  final String label;

  BaseAction get action;

  const BaseMouseButtonElement(BaseAction action,
      {this.geometry = const Geometry(), this.label = ''});

  @override
  Widget build(BuildContext context);
}
