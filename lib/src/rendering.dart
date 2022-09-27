import 'dart:collection';

import 'package:flutter/widgets.dart';

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
  double? maxWidth;
  double? maxHeight;

  /// Example: EdgeInsets.all(0)
  bool? expand;
  EdgeInsets? padding;
}

class FlexibleGeometry extends Geometry {}

abstract class RCElement {
  Geometry get geometry;

  String label;

  RCElement(this.label);

  Widget build();
}

abstract class Layout extends RCElement {
  List<RCElement> get children;

  Layout(Geometry geometry, String label) : super(label);
}

enum Direction { Row, Column }

class FlexLayout implements Layout {
  @override
  FlexibleGeometry geometry;

  Direction direction = Direction.Row;
  String description = '';
  double columnGap = 0;
  double rowGap = 0;

  FlexLayout(this.geometry, this.direction, this.description, this.columnGap,
      this.rowGap,
      {String? label});

  @override
  List<RCElement> children = [];

  @override
  String label = '';

  @override
  Widget build() {
    if (direction == Direction.Row) {
      return Padding(
        padding: geometry.padding ?? EdgeInsets.all(0),
        child: Row(
          children: children.map((e) => e.build()).toList(),
        ),
      );
    } else {
      return Padding(
        padding: geometry.padding ?? EdgeInsets.all(0),
        child: Column(
          children: children.map((e) => e.build()).toList(),
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
  Widget build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  HorizontalSpacer({String? label});
}

class VerticalSpacer implements RCElement {
  @override
  Geometry geometry = Geometry();

  @override
  String label = '';

  @override
  Widget build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  VerticalSpacer({String? label});
}
/* endregion rendering package */

/* region actions package */
/// [ActionContext] is the context in which an action is executed.
class ActionContext {
  BaseInputClientController controller;

  ActionContext(this.controller);
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
/// [BaseInputClientController] is the main controller for the input server.
/// It implements all available gRPC methods.
abstract class BaseInputClientController {}

class KeyboardWidget {
  RCElement keyboardRootNode;
  BaseInputClientController controller;
  ActionQueue actionQueue;

  KeyboardWidget(this.keyboardRootNode, this.controller, this.actionQueue);

  void doAction(RCElement element, RCAction action) {
    actionQueue.scheduleAction(ActionContext(controller), action, 1000);
  }

  void build() {

  }
}

/// [ActionTask] is a task that is scheduled by the [ActionQueue].
/// It contains the [ActionContext] in which the action is executed,
/// the [RCAction] to execute and a [timeout]
class ActionTask {
  ActionContext ctx;
  RCAction action;
  DateTime createdAt = DateTime.now();
  int timeout;

  ActionTask(this.ctx, this.action, this.timeout);

  bool doAction() {
    return action.doAction(ctx);
  }
}

class ActionQueue {
  BaseInputClientController controller;
  Queue<ActionTask> queue = Queue();

  void scheduleAction(ActionContext ctx, RCAction action, int timeout) {
    queue.add(ActionTask(ctx, action, timeout));
  }

  void processQueue() {
    while (queue.isNotEmpty) {
      var task = queue.removeFirst();
      if (task.createdAt.millisecondsSinceEpoch + task.timeout <
          DateTime.now().millisecondsSinceEpoch) {
        task.doAction();
      } else {
        queue.add(task);
      }
    }
  }

  ActionQueue(this.controller);
}
/* endregion scheduler package */
