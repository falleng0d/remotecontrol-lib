import 'package:fluent_ui/fluent_ui.dart'
    show ScaleUpdateDetails, TapDownDetails, TapUpDetails;

import '../input/virtualkeys.dart';
import 'base.dart';

/// [ActionContext] is the context in which an action is executed.
/// It contains the controller that can be used to execute other actions.
/// If the action needs additional information, it can be added to this class.
/// by extending it.
class ActionContext {
  final BaseElement target;
  final String? description;

  const ActionContext(this.target, {this.description});
}

/// [KeyActionContext] is the context in which a keyboard key action is executed.
class KeyActionContext extends ActionContext {
  final KeyState keyState;

  const KeyActionContext(BaseElement target, this.keyState, {String? description})
      : super(target, description: description);
}

/// [ButtonActionContext] is the context in which a mouse button action is executed.
class ButtonActionContext extends ActionContext {
  final ButtonState buttonState;

  const ButtonActionContext(BaseElement target, this.buttonState, {String? description})
      : super(target, description: description);
}

/// [MouseMoveActionContext] is the context in which a mouse move action is executed.
class MouseMoveActionContext extends ActionContext {
  final double deltaX;
  final double deltaY;

  const MouseMoveActionContext(BaseElement target, this.deltaX, this.deltaY,
      {String? description})
      : super(target, description: description);
}

/// [TapActionContext] is the context in which a touchpad tap action is executed.
class TapActionContext extends ActionContext {
  final TapUpDetails? tapUpDetails;
  final TapDownDetails? tapDownDetails;
  final ScaleUpdateDetails? scaleUpdateDetails;

  const TapActionContext(BaseElement target,
      {String? description,
      this.tapUpDetails,
      this.tapDownDetails,
      this.scaleUpdateDetails})
      : super(target, description: description);
}
