import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../logger.dart';

/*
  start architecture.puml
  'The aim of this model is make it possible build a serializable keyboard layout
  'The keyboad layout is a tree of keys and layout elements
  'Some key types are:
  ' - KeyboardKey: a key that sends a keyboard key key code
  ' - MouseKey: a key that sends a mouse key key code
  ' - MouseMoveKey: a key that sends a mouse move key code and move delta
  ' - KeySequence: a key composed of other keys
  'Some layout elements are:
  ' - HorizontalSpacer
  ' - VerticalSpacer
  ' -
  'Serializable hierarchical

  package rendering {
    abstract class Geometry {
      maxWidth: float?
      maxHeight: float?
      expand: bool?
      padding: Padding?
    }
    'element is a displayable control that can be added to a container
    'it should be possible to build a element into a renderable widget
    abstract class Element {
      +geometry Geometry
      +label string

      +build()
    }
    abstract class Layout {
      geometry Geometry
      children: Element[]

      +build()
    }

    class FlexibleGeometry {

    }

    class FlexLayout {
      +geometry: FlexibleGeometry
      +description: string
      +direction: "row" | "column"
      +columnGap: float
      +rowGap: float
    }

    class HorizontalSpacer {
      +build()
    }
    class VerticalSpacer {
      +build()
    }

    'Relationships
    Element <|-- Layout
    Layout <|-- FlexLayout
    Layout *- Geometry : "1..*"
    Geometry <|-- FlexibleGeometry
    FlexLayout *- FlexibleGeometry : "1..*"
    Element <|-- HorizontalSpacer
    Element <|-- VerticalSpacer
  }

  package actions {
    'action is the base class for all actions
    abstract class Command {}

    abstract class Action {
      +doAction(ctx: ActionContext): bool
    }
    note right of Action::getCommands
      Each action can have multiple commands
      associated with it.
    end note

    class SequenceAction {
      actions Action[]
    }

    enum KeyState {
      Up
      Down
    }

    abstract class KeyAction {
      state KeyState
    }

    class KeyboardKeyAction {
      keyCode KbdKeyCode
    }

    class MouseButtonAction {
      keyCode MbKeyCode
    }

    class MouseMoveAction {
      deltaX float
      deltaY float
    }

    class TypeTextAction {
      text string
    }

    class ShowMenuAction {
      hideOnRelease: bool
      pressOnRelease: bool
      actions: Action[]
    }

    Action <|-- TypeTextAction
    Action <|-- SequenceAction
    Action <|-- ShowMenuAction
    Command -* Action
    Action --* SequenceAction
    Action <|-- KeyAction
    KeyAction <|-- KeyboardKeyAction
    KeyAction <|-- MouseButtonAction
    KeyState *-- KeyAction
    Action <|-- MouseMoveAction
  }

  package interactive {
    class Button {
      +geometry: FlexibleGeometry
      +label: string
      +keyRep eat: float
      +keyRepeatDelay: float
      +toggle: bool
      -action Action
      +holdTimeThreshold: float
      -holdAction Action?
      +doubleTapThershold: float
      -doubleTapAction Action?

      +build()
    }
    class Touchpad {
      +sensitivity int?
      +scrollbar bool
      +mouseButtons bool
      +tapToClick bool
      +doubleTapAndHold bool

      +build()
    }


    'Relationships
    Action --* Button::action
    Element <|-- Button
    Element <|-- Touchpad
  }

  package fltter_widgets {
    class ButtonWidget {
      button Button

      -onClick()
      +build()
    }

    Button <|-- ButtonWidget
  }

  package scheduler {
    struct ActionContext {
      controller InputServerController
    }

    class KbdController {
      keyboardRootNode Element
      controller InputServerController
      queue ActionQueue

      +doAction(widget, action)
    }

    class ActionQueue {
      controller InputServerController

      +scheduleAction(ctx, action, timeout)
    }

    KbdController *-- ActionQueue
    KbdController::doAction <-- ButtonWidget::onClick
    KbdController::doAction --> ActionQueue::scheduleAction
  }
  end architecture.puml
*/

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

abstract class RCElement {
  Geometry get geometry;

  String label;

  RCElement(this.label);

  Widget build(BuildContext context);
}

abstract class Layout extends RCElement {
  List<RCElement> get children;

  Layout(Geometry geometry, String label) : super(label);
}

enum Direction { Row, Column }

class FlexLayout implements Layout {
  @override
  FlexibleGeometry geometry;

  Direction direction;
  String description;
  double columnGap = 0;
  double rowGap = 0;

  FlexLayout(
      {this.geometry = const FlexibleGeometry(),
      this.direction = Direction.Row,
      this.description = '',
      this.columnGap = 0,
      this.rowGap = 0,
      String? label,
      required this.children});

  @override
  List<RCElement> children;

  @override
  String label = '';

  @override
  Widget build(BuildContext context) {
    if (direction == Direction.Row) {
      return Padding(
        padding: geometry.padding ?? EdgeInsets.all(0),
        child: Row(
          children: children.map((e) => e.build(context)).toList(),
        ),
      );
    } else {
      return Padding(
        padding: geometry.padding ?? EdgeInsets.all(0),
        child: Column(
          children: children.map((e) => e.build(context)).toList(),
        ),
      );
    }
  }
}

class HorizontalSpacer implements RCElement {
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

class VerticalSpacer implements RCElement {
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
  final KeyboardController controller;
  final RCElement target;

  const ActionContext(this.controller, this.target);
}

/// [RCAction] is the base class for all actions
/// An action is a command that can be executed by the system.
/// It receives a [ActionContext] and returns a boolean indicating if the action
/// was executed successfully.
///
/// An action should not be executed directly, but rather scheduled through
/// a [ActionQueue].
abstract class RCAction {
  bool doAction(ActionContext ctx);
}

class RCCallbackAction implements RCAction {
  final bool Function(ActionContext) callback;

  RCCallbackAction(this.callback);

  @override
  bool doAction(ActionContext ctx) {
    return callback(ctx);
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
  bool doAction(ActionContext ctx) {
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
  bool doAction(ActionContext ctx) {
    // TODO: implement doAction
    throw UnimplementedError();
  }
}

class MouseMoveAction implements RCAction {
  double deltaX;
  double deltaY;

  MouseMoveAction(this.deltaX, this.deltaY);

  @override
  bool doAction(ActionContext ctx) {
    // TODO: implement doAction
    throw UnimplementedError();
  }
}
/* endregion actions package */

/* region scheduler package */
class KeyboardController {
  final RCElement rootElement;
  final ActionQueue _actionQueue = ActionQueue();

  KeyboardController({required this.rootElement});

  void doAction(RCElement element, RCAction action) {
    _actionQueue.scheduleAction(createContext(element), action, 1000);
  }

  ActionContext createContext(RCElement element) {
    return ActionContext(this, element);
  }

  Widget build(BuildContext context) {
    return rootElement.build(context);
  }
}

/// [ActionTask] is a task that is scheduled by the [ActionQueue].
/// It contains the [ActionContext] in which the action is executed,
/// the [RCAction] to execute and a [timeout]
class ActionTask {
  final ActionContext ctx;
  final RCAction action;
  final DateTime createdAt = DateTime.now();
  final int timeout;

  ActionTask(this.ctx, this.action, this.timeout);

  bool doAction() {
    return action.doAction(ctx);
  }
}

class ActionQueue {
  final Queue<ActionTask> queue = Queue();

  void scheduleAction(ActionContext ctx, RCAction action, int timeout) {
    queue.add(ActionTask(ctx, action, timeout));
    processQueue();
  }

  void processQueue() {
    while (queue.isNotEmpty) {
      var task = queue.removeFirst();
      var createdAt = task.createdAt.millisecondsSinceEpoch;
      var now = DateTime.now().millisecondsSinceEpoch;
      var expiresAt = createdAt + task.timeout;
      if (now > expiresAt) {
        Logger.instance().trace(
            '[ActionQueue] Skipping expired task, expires at $expiresAt, now is $now (expired by ${now - expiresAt}ms)');
        continue;
      } else {
        task.doAction();
      }
    }
  }

  ActionQueue();
}
/* endregion scheduler package */
