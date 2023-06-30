import '../actions/action_contexts.dart';
import '../virtualkeys.dart';

/// [BaseAction] is the base class for all actions. Action objects are meant to
/// contain everything that is needed to execute an action for a
/// given [BaseActionContext].
///
/// An action is a command that can be executed by the system.
/// It receives a [BaseActionContext] and returns a boolean indicating if the action
/// was executed successfully.
///
/// An action should not be executed directly, but rather scheduled through
/// a [ActionQueue].
abstract class BaseAction<T extends BaseActionContext> {
  const BaseAction();

  Future<bool> doAction(covariant T ctx);
}

abstract class BaseKeyAction extends BaseAction<BaseKeyActionContext> {
  int get keyCode;

  const BaseKeyAction(int keyCode);

  @override
  Future<bool> doAction(BaseKeyActionContext ctx);
}

abstract class BaseMouseButtonAction extends BaseAction<BaseButtonActionContext> {
  MouseButtonType get button;

  const BaseMouseButtonAction(MouseButtonType button);

  @override
  Future<bool> doAction(BaseButtonActionContext ctx);
}

abstract class BaseMouseMoveAction extends BaseAction<BaseMouseMoveActionContext> {
  const BaseMouseMoveAction();

  @override
  Future<bool> doAction(BaseMouseMoveActionContext ctx);
}
