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

  double keyRep = 0;
  double keyRepeatDelay = 0;
  bool toggle = false;

  BaseAction action;
  double holdTimeThreshold = 0;
  BaseAction? holdAction;
  double doubleTapThershold = 0;
  BaseAction? doubleTapAction;

  BaseKeyElement(
      {this.geometry = const Geometry(), this.label = '', required this.action});

  @override
  Widget build(BuildContext context);
}

abstract class BaseTouchpadElement implements BaseElement {
  @override
  Geometry geometry;
  @override
  String label;

  bool scrollbar;
  bool mouseButtons;
  bool tapToClick;
  bool doubleTapAndHold;
  TouchpadActions actions;

  BaseTouchpadElement(
      {this.geometry = const Geometry(),
      this.label = '',
      this.scrollbar = true,
      this.mouseButtons = true,
      this.tapToClick = true,
      this.doubleTapAndHold = true,
      required this.actions});

  @override
  Widget build(BuildContext context);
}

abstract class BaseMouseButtonElement implements BaseElement {
  @override
  Geometry geometry;
  @override
  String label;

  BaseAction action;

  BaseMouseButtonElement(
      {this.geometry = const Geometry(), this.label = '', required this.action});

  @override
  Widget build(BuildContext context);
}
