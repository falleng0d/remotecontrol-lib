import 'action_contexts.dart';

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
  Future<bool> doAction(ActionContext ctx);
}

abstract class BaseKeyAction implements BaseAction {
  int get keyCode;

  const BaseKeyAction();

  @override
  Future<bool> doAction(ActionContext ctx);
}

abstract class BaseMouseButtonAction implements BaseAction {
  int get keyCode;

  const BaseMouseButtonAction(int keyCode);

  @override
  Future<bool> doAction(ActionContext ctx);
}

abstract class BaseMouseMoveAction implements BaseAction {
  const BaseMouseMoveAction();

  @override
  Future<bool> doAction(ActionContext ctx);
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
  final Future<bool> Function(ActionContext) callback;

  const CallbackAction(this.callback);

  @override
  Future<bool> doAction(ActionContext ctx) async {
    return await callback(ctx);
  }
}
