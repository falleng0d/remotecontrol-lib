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

class KeyActionContext extends ActionContext {
  KeyState keyState;

  KeyActionContext(BaseElement element, this.keyState, {String? description})
      : super(element, description: description);
}

class MouseMoveActionContext extends ActionContext {
  double deltaX;
  double deltaY;

  MouseMoveActionContext(BaseElement element, this.deltaX, this.deltaY,
      {String? description})
      : super(element, description: description);
}

/// [BaseAction] is the base class for all actions. Action objects are meant to
/// contain everything that is needed to execute an action for a
/// given [ActionContext].
///
/// An action is a command that can be executed by the system.
/// It receives a [ActionContext] and returns a boolean indicating if the action
/// was executed successfully.
///
/// An action should not be executed directly, but rather scheduled through
/// a [ActionQueue].
abstract class BaseAction {
  Future<void> doAction(ActionContext ctx);
}

/// [CallbackAction] is a simple action that executes a callback.
///
/// An action is a command that can be executed by the system.
/// It receives a [ActionContext] and returns a boolean indicating if the action
/// was executed successfully.
///
/// An action should not be executed directly, but rather scheduled through
/// a [ActionQueue].
class CallbackAction implements BaseAction {
  final Future<void> Function(ActionContext) callback;

  CallbackAction(this.callback);

  @override
  Future<void> doAction(ActionContext ctx) async {
    return await callback(ctx);
  }
}

abstract class BaseKeyAction implements BaseAction {
  int get keyCode;

  BaseKeyAction(KeyState state);

  @override
  Future<void> doAction(ActionContext ctx);
}

abstract class BaseMouseButtonAction implements BaseAction {
  int get keyCode;

  BaseMouseButtonAction(KeyState state, int keyCode);

  @override
  Future<void> doAction(ActionContext ctx);
}

abstract class BaseMouseMoveAction implements BaseAction {
  BaseMouseMoveAction();

  @override
  Future<void> doAction(ActionContext ctx);
}
