import 'package:flutter/gestures.dart';

import '../input/virtualkeys.dart';
import 'layout.dart';

/// [ActionContext] is the context in which an action is executed.
/// It contains the controller that can be used to execute other actions.
/// If the action needs additional information, it can be added to this class.
/// by extending it.
class ActionContext {
  final BaseElement target;
  final String? description;

  const ActionContext(this.target, {this.description});
}

/// [RCAction] is the base class for all actions
///
/// An action is a command that can be executed by the system.
/// It receives a [ActionContext] and returns a boolean indicating if the action
/// was executed successfully.
///
/// An action should not be executed directly, but rather scheduled through
/// a [ActionQueue].
abstract class RCAction {
  Future<void> doAction(ActionContext ctx);
}

/// [RCCallbackAction] is a simple action that executes a callback.
///
/// An action is a command that can be executed by the system.
/// It receives a [ActionContext] and returns a boolean indicating if the action
/// was executed successfully.
///
/// An action should not be executed directly, but rather scheduled through
/// a [ActionQueue].
class RCCallbackAction implements RCAction {
  final Future<void> Function(ActionContext) callback;

  RCCallbackAction(this.callback);

  @override
  Future<void> doAction(ActionContext ctx) async {
    return await callback(ctx);
  }
}

abstract class BaseKeyAction implements RCAction {
  KeyState get state;
}

class KeyAction implements BaseKeyAction {
  @override
  KeyState state;
  int keyCode;

  KeyAction(this.state, this.keyCode);

  @override
  Future<void> doAction(ActionContext ctx) {
    // TODO: implement doAction
    throw UnimplementedError();
  }
}

class MouseButtonAction implements BaseKeyAction {
  @override
  KeyState state;
  int keyCode;

  MouseButtonAction(this.state, this.keyCode);

  @override
  Future<void> doAction(ActionContext ctx) {
    // TODO: implement doAction
    throw UnimplementedError();
  }
}

class MouseMoveAction implements RCAction {
  double deltaX;
  double deltaY;

  MouseMoveAction(this.deltaX, this.deltaY);

  @override
  Future<void> doAction(ActionContext ctx) {
    // TODO: implement doAction
    throw UnimplementedError();
  }
}

class TapActionContext extends ActionContext {
  TapUpDetails? tapUpDetails;
  TapDownDetails? tapDownDetails;
  ScaleUpdateDetails? scaleUpdateDetails;

  TapActionContext(BaseElement element,
      {String? description,
      this.tapUpDetails,
      this.tapDownDetails,
      this.scaleUpdateDetails})
      : super(element, description: description);
}

class TouchpadActions {
  RCAction? touchpadMove;
  RCAction? tap;
  RCAction? doubleTapAndHold;
  RCAction? releaseDoubleTapAndHold;

  TouchpadActions({
    this.touchpadMove,
    this.tap,
    this.doubleTapAndHold,
    this.releaseDoubleTapAndHold,
  });
}
