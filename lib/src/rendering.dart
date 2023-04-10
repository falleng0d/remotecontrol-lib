import 'package:flutter/widgets.dart';
import 'package:remotecontrol_lib/src/CrossExpanded.dart';

import '../logger.dart';

/* region rendering package */
class Geometry {
  final double? maxWidth;
  final double? maxHeight;

  /// Example: EdgeInsets.all(0)
  final bool? expand;
  final EdgeInsets? padding;

  const Geometry({this.maxWidth, this.maxHeight, this.expand, this.padding});
}

class FlexibleGeometry extends Geometry {
  const FlexibleGeometry(
      {super.maxWidth, super.maxHeight, super.expand, super.padding});
}

/// A [KBBaseElement] is a displayable control that can be added to a [Layout]
abstract class KBBaseElement {
  Geometry get geometry;

  String label;

  KBBaseElement(this.label);

  Widget build(BuildContext context);
}

abstract class Layout extends KBBaseElement {
  List<KBBaseElement> get children;

  Layout(Geometry geometry, String label) : super(label);
}

enum Direction { Row, Column }

class FlexLayout implements Layout {
  @override
  FlexibleGeometry geometry;

  Direction direction;
  String description;
  double columnGap;
  double rowGap;
  bool expandChildren;

  FlexLayout(
      {this.geometry = const FlexibleGeometry(),
      this.direction = Direction.Row,
      this.description = '',
      this.columnGap = 0,
      this.rowGap = 0,
      this.expandChildren = false,
      String? label,
      required this.children});

  @override
  List<KBBaseElement> children;

  @override
  String label = '';

  @override
  Widget build(BuildContext context) {
    // Container assemble
    var addContainer = (List<Widget> children) {
      if (direction == Direction.Row) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );
      } else {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: children,
        );
      }
    };
    var addExpand = (Widget widget) {
      if (geometry.expand == true) {
        return CrossExpanded(child: widget);
      } else {
        return widget;
      }
    };

    // Children assemble
    var addPadding = (Widget widget) {
      if (geometry.padding != null) {
        return Padding(
          padding: geometry.padding!,
          child: widget,
        );
      } else {
        return widget;
      }
    };
    var addSize = (Widget widget) {
      if (geometry.maxWidth != null || geometry.maxHeight != null) {
        return SizedBox(
          width: geometry.maxWidth,
          height: geometry.maxHeight,
          child: widget,
        );
      } else {
        return widget;
      }
    };
    var addExpandToChildren = (Widget widget) {
      if (expandChildren == true) {
        return CrossExpanded(child: widget);
      } else {
        return widget;
      }
    };

    var transformChildren = (Widget widget) {
      widget = addSize(widget);
      widget = addPadding(widget);
      widget = addExpandToChildren(widget);
      return widget;
    };

    var assemble = (List<Widget> children) {
      Widget widget;
      if (children.length > 1) {
        widget = addContainer(children);
      } else {
        widget = children[0];
      }
      widget = addExpand(widget);
      return widget;
    };

    var _children =
        children.map((e) => transformChildren(e.build(context))).toList();
    return assemble(_children);
  }
}

class HorizontalSpacer implements KBBaseElement {
  @override
  Geometry geometry = Geometry();

  @override
  String label = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  HorizontalSpacer({String? label, this.geometry = const Geometry()});
}

class VerticalSpacer implements KBBaseElement {
  @override
  Geometry geometry = Geometry();

  @override
  String label = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  VerticalSpacer({String? label, this.geometry = const Geometry()});
}
/* endregion rendering package */

/* region actions package */

/// [ActionContext] is the context in which an action is executed.
/// It contains the controller that can be used to execute other actions.
/// If the action needs additional information, it can be added to this class.
/// by extending it.
class ActionContext {
  final KBBaseElement target;
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

enum KeyState { Up, Down }

abstract class KeyAction implements RCAction {
  KeyState get state;
}

class KeyboardKeyAction implements KeyAction {
  @override
  KeyState state;
  int keyCode;

  KeyboardKeyAction(this.state, this.keyCode);

  @override
  Future<void> doAction(ActionContext ctx) {
    // TODO: implement doAction
    throw UnimplementedError();
  }
}

class MouseButtonAction implements KeyAction {
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
/* endregion actions package */

/* region scheduler package */
class VirtualKeyboard {
  final KBBaseElement child;
  final Logger? logger;

  VirtualKeyboard({required this.child, this.logger});

  Widget build(BuildContext context) {
    return child.build(context);
  }
}

/// [ActionTask] is a task that is scheduled by the [ActionQueue].
/// It contains the [ActionContext] in which the action is executed,
/// the [RCAction] to execute and a [timeout]
class ActionTask {
  final ActionContext ctx;
  final RCAction action;
  final DateTime createdAt = DateTime.now();
  final int? timeout;

  ActionTask(this.ctx, this.action, this.timeout);

  /// Executes the action and returns a [Future] that completes when the action
  /// is finished or the timeout is reached.
  /// If the timeout is reached, a [TimeoutException] is thrown.
  Future<void> doAction() {
    // abort if timeout is reached
    if (timeout != null) {
      return action.doAction(ctx).timeout(Duration(milliseconds: timeout!));
    }

    return action.doAction(ctx);
  }
}
/* endregion scheduler package */
