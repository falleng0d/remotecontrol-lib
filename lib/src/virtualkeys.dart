// Virtual keys
import 'package:remotecontrol_lib/proto/input.pbgrpc.dart' as pb;
import 'package:win32/win32.dart';

const VK_0 = 48;
const VK_1 = 49;
const VK_2 = 50;
const VK_3 = 51;
const VK_4 = 52;
const VK_5 = 53;
const VK_6 = 54;
const VK_7 = 55;
const VK_8 = 56;
const VK_9 = 57;
const VK_A = 65;
const VK_B = 66;
const VK_C = 67;
const VK_D = 68;
const VK_E = 69;
const VK_F = 70;
const VK_G = 71;
const VK_H = 72;
const VK_I = 73;
const VK_J = 74;
const VK_K = 75;
const VK_L = 76;
const VK_M = 77;
const VK_N = 78;
const VK_O = 79;
const VK_P = 80;
const VK_Q = 81;
const VK_R = 82;
const VK_S = 83;
const VK_T = 84;
const VK_U = 85;
const VK_V = 86;
const VK_W = 87;
const VK_X = 88;
const VK_Y = 89;
const VK_Z = 90;
const VK_SHIFT = 160;

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

pb.MouseKey_KeyActionType buttonActionTypeToPb(ButtonActionType state) {
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

class MouseButton {
  final MouseButtonType button;
  final int keyDown;
  final int keyUp;

  const MouseButton(this.button, this.keyDown, this.keyUp);

  // construct from MouseButton
  static MouseButton fromMouseButton(MouseButtonType button) {
    switch (button) {
      case MouseButtonType.LEFT:
        return MouseButton(button, MOUSE_EVENT_FLAGS.MOUSEEVENTF_LEFTDOWN,
            MOUSE_EVENT_FLAGS.MOUSEEVENTF_LEFTUP);
      case MouseButtonType.RIGHT:
        return MouseButton(button, MOUSE_EVENT_FLAGS.MOUSEEVENTF_RIGHTDOWN,
            MOUSE_EVENT_FLAGS.MOUSEEVENTF_RIGHTUP);
      case MouseButtonType.MIDDLE:
        return MouseButton(button, MOUSE_EVENT_FLAGS.MOUSEEVENTF_MIDDLEDOWN,
            MOUSE_EVENT_FLAGS.MOUSEEVENTF_MIDDLEUP);
      case MouseButtonType.X1:
        return MouseButton(button, MOUSE_EVENT_FLAGS.MOUSEEVENTF_XDOWN,
            MOUSE_EVENT_FLAGS.MOUSEEVENTF_XUP);
      case MouseButtonType.X2:
        throw UnimplementedError('X2 button not implemented');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MouseButton &&
          runtimeType == other.runtimeType &&
          keyDown == other.keyDown &&
          keyUp == other.keyUp;

  @override
  int get hashCode => keyDown.hashCode ^ keyUp.hashCode;

  @override
  String toString() {
    return button.toString();
  }
}

const MB_LEFT = MouseButton(MouseButtonType.LEFT, MOUSE_EVENT_FLAGS.MOUSEEVENTF_LEFTDOWN,
    MOUSE_EVENT_FLAGS.MOUSEEVENTF_LEFTUP);
const MB_RIGHT = MouseButton(MouseButtonType.RIGHT,
    MOUSE_EVENT_FLAGS.MOUSEEVENTF_RIGHTDOWN, MOUSE_EVENT_FLAGS.MOUSEEVENTF_RIGHTUP);
const MB_MIDDLE = MouseButton(MouseButtonType.MIDDLE,
    MOUSE_EVENT_FLAGS.MOUSEEVENTF_MIDDLEDOWN, MOUSE_EVENT_FLAGS.MOUSEEVENTF_MIDDLEUP);
const MB_X = MouseButton(MouseButtonType.X1, MOUSE_EVENT_FLAGS.MOUSEEVENTF_XDOWN,
    MOUSE_EVENT_FLAGS.MOUSEEVENTF_XUP);

const Map<String, int> _keyToVK = {
  '0': VIRTUAL_KEY.VK_0,
  '1': VIRTUAL_KEY.VK_1,
  '2': VIRTUAL_KEY.VK_2,
  '3': VIRTUAL_KEY.VK_3,
  '4': VIRTUAL_KEY.VK_4,
  '5': VIRTUAL_KEY.VK_5,
  '6': VIRTUAL_KEY.VK_6,
  '7': VIRTUAL_KEY.VK_7,
  '8': VIRTUAL_KEY.VK_8,
  '9': VIRTUAL_KEY.VK_9,
  'A': VIRTUAL_KEY.VK_A,
  'B': VIRTUAL_KEY.VK_B,
  'C': VIRTUAL_KEY.VK_C,
  'D': VIRTUAL_KEY.VK_D,
  'E': VIRTUAL_KEY.VK_E,
  'F': VIRTUAL_KEY.VK_F,
  'G': VIRTUAL_KEY.VK_G,
  'H': VIRTUAL_KEY.VK_H,
  'I': VIRTUAL_KEY.VK_I,
  'J': VIRTUAL_KEY.VK_J,
  'K': VIRTUAL_KEY.VK_K,
  'L': VIRTUAL_KEY.VK_L,
  'M': VIRTUAL_KEY.VK_M,
  'N': VIRTUAL_KEY.VK_N,
  'O': VIRTUAL_KEY.VK_O,
  'P': VIRTUAL_KEY.VK_P,
  'Q': VIRTUAL_KEY.VK_Q,
  'R': VIRTUAL_KEY.VK_R,
  'S': VIRTUAL_KEY.VK_S,
  'T': VIRTUAL_KEY.VK_T,
  'U': VIRTUAL_KEY.VK_U,
  'V': VIRTUAL_KEY.VK_V,
  'W': VIRTUAL_KEY.VK_W,
  'X': VIRTUAL_KEY.VK_X,
  'Y': VIRTUAL_KEY.VK_Y,
  'Z': VIRTUAL_KEY.VK_Z,
  'F1': VIRTUAL_KEY.VK_F1,
  'F2': VIRTUAL_KEY.VK_F2,
  'F3': VIRTUAL_KEY.VK_F3,
  'F4': VIRTUAL_KEY.VK_F4,
  'F5': VIRTUAL_KEY.VK_F5,
  'F6': VIRTUAL_KEY.VK_F6,
  'F7': VIRTUAL_KEY.VK_F7,
  'F8': VIRTUAL_KEY.VK_F8,
  'F9': VIRTUAL_KEY.VK_F9,
  'F10': VIRTUAL_KEY.VK_F10,
  'F11': VIRTUAL_KEY.VK_F11,
  'F12': VIRTUAL_KEY.VK_F12,
  'NUMLOCK': VIRTUAL_KEY.VK_NUMLOCK,
  'SCROLLLOCK': VIRTUAL_KEY.VK_SCROLL,
  'BACKSPACE': VIRTUAL_KEY.VK_BACK,
  'TAB': VIRTUAL_KEY.VK_TAB,
  'ENTER': VIRTUAL_KEY.VK_RETURN,
  'SHIFT': VIRTUAL_KEY.VK_SHIFT,
  'LSHIFT': VIRTUAL_KEY.VK_LSHIFT,
  'RSHIFT': VIRTUAL_KEY.VK_RSHIFT,
  'CTRL': VIRTUAL_KEY.VK_CONTROL,
  'LCTRL': VIRTUAL_KEY.VK_LCONTROL,
  'RCTRL': VIRTUAL_KEY.VK_RCONTROL,
  'ALT': VIRTUAL_KEY.VK_MENU,
  'LALT': VIRTUAL_KEY.VK_LMENU,
  'RALT': VIRTUAL_KEY.VK_RMENU,
  'CAPITAL': VIRTUAL_KEY.VK_CAPITAL,
  'KANA': VIRTUAL_KEY.VK_KANA,
  'HANGEUL': VIRTUAL_KEY.VK_HANGEUL,
  'HANGUL': VIRTUAL_KEY.VK_HANGUL,
  'JUNJA': VIRTUAL_KEY.VK_JUNJA,
  'FINAL': VIRTUAL_KEY.VK_FINAL,
  'HANJA': VIRTUAL_KEY.VK_HANJA,
  'KANJI': VIRTUAL_KEY.VK_KANJI,
  'ESCAPE': VIRTUAL_KEY.VK_ESCAPE,
  'CONVERT': VIRTUAL_KEY.VK_CONVERT,
  'NONCONVERT': VIRTUAL_KEY.VK_NONCONVERT,
  'ACCEPT': VIRTUAL_KEY.VK_ACCEPT,
  'MODECHANGE': VIRTUAL_KEY.VK_MODECHANGE,
  'SPACE': VIRTUAL_KEY.VK_SPACE,
  'PRIOR': VIRTUAL_KEY.VK_PRIOR,
  'NEXT': VIRTUAL_KEY.VK_NEXT,
  'END': VIRTUAL_KEY.VK_END,
  'HOME': VIRTUAL_KEY.VK_HOME,
  'LEFT': VIRTUAL_KEY.VK_LEFT,
  'UP': VIRTUAL_KEY.VK_UP,
  'RIGHT': VIRTUAL_KEY.VK_RIGHT,
  'DOWN': VIRTUAL_KEY.VK_DOWN,
  'SELECT': VIRTUAL_KEY.VK_SELECT,
  'PRINT': VIRTUAL_KEY.VK_PRINT,
  'EXECUTE': VIRTUAL_KEY.VK_EXECUTE,
  'SNAPSHOT': VIRTUAL_KEY.VK_SNAPSHOT,
  'INSERT': VIRTUAL_KEY.VK_INSERT,
  'DELETE': VIRTUAL_KEY.VK_DELETE,
  'HELP': VIRTUAL_KEY.VK_HELP,
  'WIN': VIRTUAL_KEY.VK_LWIN,
  'LWIN': VIRTUAL_KEY.VK_LWIN,
  'RWIN': VIRTUAL_KEY.VK_RWIN,
  'APPS': VIRTUAL_KEY.VK_APPS,
  'SLEEP': VIRTUAL_KEY.VK_SLEEP,
  'PGUP': VIRTUAL_KEY.VK_PRIOR,
  'PGDOWN': VIRTUAL_KEY.VK_NEXT,
  'N0': VIRTUAL_KEY.VK_NUMPAD0,
  'N1': VIRTUAL_KEY.VK_NUMPAD1,
  'N2': VIRTUAL_KEY.VK_NUMPAD2,
  'N3': VIRTUAL_KEY.VK_NUMPAD3,
  'N4': VIRTUAL_KEY.VK_NUMPAD4,
  'N5': VIRTUAL_KEY.VK_NUMPAD5,
  'N6': VIRTUAL_KEY.VK_NUMPAD6,
  'N7': VIRTUAL_KEY.VK_NUMPAD7,
  'N8': VIRTUAL_KEY.VK_NUMPAD8,
  'N9': VIRTUAL_KEY.VK_NUMPAD9,
  '*': VIRTUAL_KEY.VK_MULTIPLY,
  '+': VIRTUAL_KEY.VK_ADD,
  ',': VIRTUAL_KEY.VK_OEM_COMMA,
  '-': VIRTUAL_KEY.VK_OEM_MINUS,
  '.': VIRTUAL_KEY.VK_OEM_PERIOD,
  '/': VIRTUAL_KEY.VK_OEM_2,
  ';': VIRTUAL_KEY.VK_OEM_1,
  '=': VIRTUAL_KEY.VK_OEM_PLUS,
  '[': VIRTUAL_KEY.VK_OEM_4,
  ']': VIRTUAL_KEY.VK_OEM_6,
  '\\': VIRTUAL_KEY.VK_OEM_5,
  '\'': VIRTUAL_KEY.VK_OEM_7,
  '"': VIRTUAL_KEY.VK_OEM_7,
  '`': VIRTUAL_KEY.VK_OEM_3,
  '_': VIRTUAL_KEY.VK_OEM_MINUS,
  '!': VIRTUAL_KEY.VK_1,
  '?': VIRTUAL_KEY.VK_OEM_2,
  'MEDIA_PLAY': VIRTUAL_KEY.VK_MEDIA_PLAY_PAUSE,
  'MEDIA_PREVIOUS': VIRTUAL_KEY.VK_MEDIA_PREV_TRACK,
  'MEDIA_NEXT': VIRTUAL_KEY.VK_MEDIA_NEXT_TRACK,
  'MEDIA_MUTE': VIRTUAL_KEY.VK_VOLUME_MUTE,
  'MEDIA_VOLUME_UP': VIRTUAL_KEY.VK_VOLUME_UP,
  'MEDIA_VOLUME_DOWN': VIRTUAL_KEY.VK_VOLUME_DOWN,
  'MEDIA_STOP': VIRTUAL_KEY.VK_MEDIA_STOP,
  'MEDIA_SELECT': VIRTUAL_KEY.VK_LAUNCH_MEDIA_SELECT,
  'MEDIA_EMAIL': VIRTUAL_KEY.VK_LAUNCH_MAIL,
  'MEDIA_CALCULATOR': VIRTUAL_KEY.VK_LAUNCH_APP1,
  'MEDIA_BACK': VIRTUAL_KEY.VK_BROWSER_BACK,
  'MEDIA_FORWARD': VIRTUAL_KEY.VK_BROWSER_FORWARD,
  'MEDIA_REFRESH': VIRTUAL_KEY.VK_BROWSER_REFRESH,
};

Map<int, String> _vKToKey = _keyToVK.map((k, v) => MapEntry(v, k));

class InvalidKeyException implements Exception {
  final String message;

  InvalidKeyException(this.message);

  @override
  String toString() {
    return 'InvalidKeyException: $message';
  }
}

int keyToVK(String key) {
  key = key.toUpperCase();

  if (_keyToVK.containsKey(key)) {
    return _keyToVK[key]!;
  }

  throw InvalidKeyException('No VK for key: $key');
}

String vkToKey(int vk) {
  if (_vKToKey.containsKey(vk)) {
    return _vKToKey[vk]!;
  }

  throw Exception('Invalid VK: $vk');
}

const List<int> _modifiers = [
  VIRTUAL_KEY.VK_SHIFT,
  VIRTUAL_KEY.VK_LSHIFT,
  VIRTUAL_KEY.VK_RSHIFT,
  VIRTUAL_KEY.VK_CONTROL,
  VIRTUAL_KEY.VK_LCONTROL,
  VIRTUAL_KEY.VK_RCONTROL,
  VIRTUAL_KEY.VK_MENU,
  VIRTUAL_KEY.VK_LMENU,
  VIRTUAL_KEY.VK_RMENU,
  VIRTUAL_KEY.VK_LWIN,
  VIRTUAL_KEY.VK_RWIN,
];

bool isModifierKey(int vk) => _modifiers.contains(vk);

List<int> getModifiers() => _modifiers;

String keyNameToShiftName(String keyName) {
  switch (keyName) {
    case '/':
      return '?';
    case '\\':
      return '|';
    case '[':
      return '{';
    case ']':
      return '}';
    case ';':
      return ':';
    case ',':
      return '<';
    case '.':
      return '>';
    case '\'':
      return '"';
    case '`':
      return '~';
    case '-':
      return '_';
    case '=':
      return '+';
    case '0':
      return ')';
    case '1':
      return '!';
    case '2':
      return '@';
    case '3':
      return '#';
    case '4':
      return '\$';
    case '5':
      return '%';
    case '6':
      return '^';
    case '7':
      return '&';
    case '8':
      return '*';
    case '9':
      return '(';
    case 'Space':
      return 'Space';
    case 'Tab':
      return 'Tab';
    case 'Home':
      return 'Home';
    case 'End':
      return 'End';
    case 'Esc':
      return 'Esc';
    default:
      return keyName.toUpperCase();
  }
}
