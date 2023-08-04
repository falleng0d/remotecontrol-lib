import '../actions/action_contexts.dart';
import '../logger/logger.dart';
import 'action_base.dart';

/// [ActionTask] is a task contains the [BaseActionContext] in which the action
/// is executed, the [BaseAction] to execute and a [timeout]
class ActionTask {
  final BaseActionContext ctx;
  final BaseAction action;
  final DateTime createdAt = DateTime.now();
  final int? timeout;

  ActionTask(this.ctx, this.action, this.timeout);

  /// Executes the action and returns a [Future] that completes when the action
  /// is finished or the timeout is reached.
  /// If the timeout is reached, a [TimeoutException] is thrown.
  Future<bool> doAction() async {
    // abort if timeout is reached
    if (timeout != null) {
      final now = DateTime.now();
      final result = timeout! > 0
          ? await action.doAction(ctx).timeout(Duration(milliseconds: timeout!))
          : await action.doAction(ctx);
      final elapsed = DateTime.now().difference(now).inMilliseconds;
      if (ctx.description != null && !ctx.description!.contains("Touchpad moved")) {
        logger.trace('[ActionTask]: ${ctx.description} took $elapsed ms');
      }

      return result;
    }

    return action.doAction(ctx);
  }
}
