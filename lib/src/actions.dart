import '../input/virtualkeys.dart';
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
  const BaseAction();

  Future<bool> doAction(covariant ActionContext ctx);
}

abstract class BaseKeyAction extends BaseAction {
  int get keyCode;

  const BaseKeyAction(int keyCode);

  @override
  Future<bool> doAction(KeyActionContext ctx);
}

abstract class BaseMouseButtonAction extends BaseAction {
  MouseButtonType get button;

  const BaseMouseButtonAction(MouseButtonType button);

  @override
  Future<bool> doAction(ButtonActionContext ctx);
}

abstract class BaseMouseMoveAction extends BaseAction {
  const BaseMouseMoveAction();

  @override
  Future<bool> doAction(MouseMoveActionContext ctx);
}

/// [CallbackAction] is a simple action that executes a callback.
///
/// An action is a command that can be executed by the system.
/// It receives a [ActionContext] and returns a boolean indicating if the action
/// was executed successfully.
///
/// An action should not be executed directly, but rather scheduled through
/// a [ActionQueue].
class CallbackAction extends BaseAction {
  final Future<bool> Function(ActionContext) callback;

  const CallbackAction(this.callback);

  @override
  Future<bool> doAction(ActionContext ctx) async {
    return await callback(ctx);
  }
}
