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
abstract class BaseAction<T extends ActionContext> {
  const BaseAction();

  Future<bool> doAction(covariant T ctx);
}

abstract class BaseKeyAction extends BaseAction<KeyActionContext> {
  int get keyCode;

  const BaseKeyAction(int keyCode);

  @override
  Future<bool> doAction(KeyActionContext ctx);
}

abstract class BaseMouseButtonAction extends BaseAction<ButtonActionContext> {
  MouseButtonType get button;

  const BaseMouseButtonAction(MouseButtonType button);

  @override
  Future<bool> doAction(ButtonActionContext ctx);
}

abstract class BaseMouseMoveAction extends BaseAction<MouseMoveActionContext> {
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
class CallbackAction<T extends ActionContext> extends BaseAction<T> {
  final Future<bool> Function(T) callback;

  const CallbackAction(this.callback);

  @override
  Future<bool> doAction(T ctx) async {
    return await callback(ctx);
  }
}
