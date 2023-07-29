import '../actions/action_contexts.dart';

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

typedef BaseKeyAction = BaseAction<BaseKeyActionContext>;

typedef BaseHotkeyAction = BaseAction<BaseHotkeyActionContext>;

typedef BaseMouseButtonAction = BaseAction<BaseButtonActionContext>;

typedef BaseMouseMoveAction = BaseAction<BaseMouseMoveActionContext>;

typedef BaseToggleAction = BaseAction<BaseToggleActionContext>;
