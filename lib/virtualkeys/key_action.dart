enum MouseButtonType { LEFT, RIGHT, MIDDLE, X1, X2 }

enum KeyActionType { UP, DOWN, PRESS }

enum ButtonActionType { UP, DOWN, PRESS, MOVE }

enum KeyState { UP, DOWN }

enum ButtonState { UP, DOWN }

KeyActionType keyActionTypeFromName(String actionName) {
  final name = actionName.toUpperCase();
  if (name == 'UP') {
    return KeyActionType.UP;
  } else {
    if (name == 'DOWN') {
      return KeyActionType.DOWN;
    } else {
      return KeyActionType.PRESS;
    }
  }
}

KeyState keyActionTypeToKeyState(KeyActionType action) {
  switch (action) {
    case KeyActionType.UP:
      return KeyState.UP;
    case KeyActionType.DOWN:
    case KeyActionType.PRESS:
      throw ArgumentError.value(action, 'action', 'Invalid key action type');
  }
}

