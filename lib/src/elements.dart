import 'package:flutter/widgets.dart';

import '../keyboard.dart';

abstract class BaseTextElement implements BaseElement {
  @override
  Geometry geometry;
  @override
  String label;

  @override
  Widget build(BuildContext context);

  BaseTextElement({this.geometry = const Geometry(), this.label = ''});
}

abstract class BaseKeyElement implements BaseElement {
  @override
  Geometry geometry;
  @override
  String label;

  double get keyRep;
  double get keyRepeatDelay;
  bool get toggle;

  BaseAction get action;
  double get holdTimeThreshold;
  BaseAction? get holdAction;
  double get doubleTapThershold;
  BaseAction? get doubleTapAction;

  BaseKeyElement(BaseAction action, {this.geometry = const Geometry(), this.label = ''});

  @override
  Widget build(BuildContext context);
}

/// TouchAction
/// - onPanUpdate: Send mose move events to the server via a [DragUpdateDetails] object.
class TouchpadActions {
  BaseAction? touchpadMove;
  BaseAction? tap;
  BaseAction? doubleTapAndHold;
  BaseAction? releaseDoubleTapAndHold;

  TouchpadActions({
    this.touchpadMove,
    this.tap,
    this.doubleTapAndHold,
    this.releaseDoubleTapAndHold,
  });
}

abstract class BaseTouchpadElement implements BaseElement {
  @override
  Geometry geometry;
  @override
  String label;

  TouchpadActions get actions;
  bool get scrollbar;
  bool get mouseButtons;
  bool get tapToClick;
  bool get doubleTapAndHold;

  BaseTouchpadElement(
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
  Geometry geometry;
  @override
  String label;

  BaseAction get action;

  BaseMouseButtonElement(BaseAction action,
      {this.geometry = const Geometry(), this.label = ''});

  @override
  Widget build(BuildContext context);
}
