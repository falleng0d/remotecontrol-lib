import 'action_base.dart';
import 'action_contexts.dart';

/// [CallbackAction] is a simple action that executes a callback.
///
/// An action is a command that can be executed by the system.
/// It receives a [BaseActionContext] and returns a boolean indicating if the action
/// was executed successfully.
///
/// An action should not be executed directly, but rather scheduled through
/// a [ActionQueue].
class CallbackAction<T extends BaseActionContext> extends BaseAction<T> {
  final Future<bool> Function(T) callback;

  const CallbackAction(this.callback);

  @override
  Future<bool> doAction(T ctx) async {
    return await callback(ctx);
  }
}
