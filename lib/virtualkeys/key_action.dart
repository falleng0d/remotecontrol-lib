// Virtual keys
import 'package:remotecontrol_lib/proto/input.pbgrpc.dart' as pb;
import 'package:win32/win32.dart';

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

Map<MouseButtonType, int> _mouseButtonToVK = {
  MouseButtonType.LEFT: VIRTUAL_KEY.VK_LBUTTON,
  MouseButtonType.RIGHT: VIRTUAL_KEY.VK_RBUTTON,
  MouseButtonType.MIDDLE: VIRTUAL_KEY.VK_MBUTTON,
  MouseButtonType.X1: VIRTUAL_KEY.VK_XBUTTON1,
  MouseButtonType.X2: VIRTUAL_KEY.VK_XBUTTON2,
};
Map<int, MouseButtonType> _vkToMouseButton =
_mouseButtonToVK.map((k, v) => MapEntry(v, k));

int mouseButtonToVK(MouseButtonType button) {
  if (!_mouseButtonToVK.containsKey(button)) {
    throw ArgumentError('Invalid mouse button type');
  }

  return _mouseButtonToVK[button]!;
}

MouseButtonType vkToMouseButton(int vk) {
  if (!_vkToMouseButton.containsKey(vk)) {
    throw ArgumentError('Invalid virtual key');
  }

  return _vkToMouseButton[vk]!;
}

Map<KeyActionType, pb.KeyActionType> _keyActionTypeToPb = {
  KeyActionType.UP: pb.KeyActionType.UP,
  KeyActionType.DOWN: pb.KeyActionType.DOWN,
  KeyActionType.PRESS: pb.KeyActionType.PRESS
};
Map<pb.KeyActionType, KeyActionType> _pbToKeyActionType =
_keyActionTypeToPb.map((k, v) => MapEntry(v, k));

Map<ButtonActionType, pb.MouseKey_KeyActionType> _buttonActionTypeStateToPb = {
  ButtonActionType.UP: pb.MouseKey_KeyActionType.UP,
  ButtonActionType.DOWN: pb.MouseKey_KeyActionType.DOWN,
  ButtonActionType.PRESS: pb.MouseKey_KeyActionType.PRESS
};
Map<pb.MouseKey_KeyActionType, ButtonActionType> _pbToButtonActionType =
_buttonActionTypeStateToPb.map((k, v) => MapEntry(v, k));

pb.KeyActionType keyActionTypeToPb(KeyActionType state) {
  if (!_keyActionTypeToPb.containsKey(state)) {
    throw ArgumentError('Invalid key state');
  }

  return _keyActionTypeToPb[state]!;
}

KeyActionType pbToKeyActionType(pb.KeyActionType state) {
  if (!_pbToKeyActionType.containsKey(state)) {
    throw ArgumentError('Invalid key state');
  }

  return _pbToKeyActionType[state]!;
}

pb.MouseKey_KeyActionType buttonActionThypeToPb(ButtonActionType state) {
  if (!_buttonActionTypeStateToPb.containsKey(state)) {
    throw ArgumentError('Invalid button state');
  }

  return _buttonActionTypeStateToPb[state]!;
}

ButtonActionType pbToButtonActionType(pb.MouseKey_KeyActionType state) {
  if (!_pbToButtonActionType.containsKey(state)) {
    throw ArgumentError('Invalid button state');
  }

  return _pbToButtonActionType[state]!;
}
