// Virtual keys
import 'package:flutter/foundation.dart';
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

enum MouseButtonType { LEFT, RIGHT, MIDDLE, X1, X2 }

enum KeyActionType { KEY_UP, KEY_DOWN, KEY_PRESS }

enum MouseActionType { KEY_UP, KEY_DOWN, KEY_PRESS, CURSOR_MOVE }

enum KeyState { UP, DOWN }

typedef ButtonState = KeyState;

@immutable
class MBWrapper {
  final int keyDown;
  final int keyUp;

  const MBWrapper(this.keyDown, this.keyUp);

  // construct from MouseButton
  static MBWrapper fromMouseButton(MouseButtonType button) {
    switch (button) {
      case MouseButtonType.LEFT:
        return MBWrapper(MOUSEEVENTF_LEFTDOWN, MOUSEEVENTF_LEFTUP);
      case MouseButtonType.RIGHT:
        return MBWrapper(MOUSEEVENTF_RIGHTDOWN, MOUSEEVENTF_RIGHTUP);
      case MouseButtonType.MIDDLE:
        return MBWrapper(MOUSEEVENTF_MIDDLEDOWN, MOUSEEVENTF_MIDDLEUP);
      case MouseButtonType.X1:
        return MBWrapper(MOUSEEVENTF_XDOWN, MOUSEEVENTF_XUP);
      case MouseButtonType.X2:
        throw UnimplementedError('X2 button not implemented');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MBWrapper &&
          runtimeType == other.runtimeType &&
          keyDown == other.keyDown &&
          keyUp == other.keyUp;

  @override
  int get hashCode => keyDown.hashCode ^ keyUp.hashCode;
}

const MB_LEFT = MBWrapper(MOUSEEVENTF_LEFTDOWN, MOUSEEVENTF_LEFTUP);
const MB_RIGHT = MBWrapper(MOUSEEVENTF_RIGHTDOWN, MOUSEEVENTF_RIGHTUP);
const MB_MIDDLE = MBWrapper(MOUSEEVENTF_MIDDLEDOWN, MOUSEEVENTF_MIDDLEUP);
const MB_X = MBWrapper(MOUSEEVENTF_XDOWN, MOUSEEVENTF_XUP);

const Map<String, int> _keyToVK = {
  '0': VK_0,
  '1': VK_1,
  '2': VK_2,
  '3': VK_3,
  '4': VK_4,
  '5': VK_5,
  '6': VK_6,
  '7': VK_7,
  '8': VK_8,
  '9': VK_9,
  'A': VK_A,
  'B': VK_B,
  'C': VK_C,
  'D': VK_D,
  'E': VK_E,
  'F': VK_F,
  'G': VK_G,
  'H': VK_H,
  'I': VK_I,
  'J': VK_J,
  'K': VK_K,
  'L': VK_L,
  'M': VK_M,
  'N': VK_N,
  'O': VK_O,
  'P': VK_P,
  'Q': VK_Q,
  'R': VK_R,
  'S': VK_S,
  'T': VK_T,
  'U': VK_U,
  'V': VK_V,
  'W': VK_W,
  'X': VK_X,
  'Y': VK_Y,
  'Z': VK_Z,
  'F1': VK_F1,
  'F2': VK_F2,
  'F3': VK_F3,
  'F4': VK_F4,
  'F5': VK_F5,
  'F6': VK_F6,
  'F7': VK_F7,
  'F8': VK_F8,
  'F9': VK_F9,
  'F10': VK_F10,
  'F11': VK_F11,
  'F12': VK_F12,
  'NUMLOCK': VK_NUMLOCK,
  'SCROLLLOCK': VK_SCROLL,
  'BACKSPACE': VK_BACK,
  'TAB': VK_TAB,
  'ENTER': VK_RETURN,
  'SHIFT': VK_SHIFT,
  'LSHIFT': VK_LSHIFT,
  'RSHIFT': VK_RSHIFT,
  'CTRL': VK_CONTROL,
  'LCTRL': VK_LCONTROL,
  'RCTRL': VK_RCONTROL,
  'ALT': VK_MENU,
  'LALT': VK_LMENU,
  'RALT': VK_RMENU,
  'CAPITAL': VK_CAPITAL,
  'KANA': VK_KANA,
  'HANGEUL': VK_HANGEUL,
  'HANGUL': VK_HANGUL,
  'JUNJA': VK_JUNJA,
  'FINAL': VK_FINAL,
  'HANJA': VK_HANJA,
  'KANJI': VK_KANJI,
  'ESCAPE': VK_ESCAPE,
  'CONVERT': VK_CONVERT,
  'NONCONVERT': VK_NONCONVERT,
  'ACCEPT': VK_ACCEPT,
  'MODECHANGE': VK_MODECHANGE,
  'SPACE': VK_SPACE,
  'PRIOR': VK_PRIOR,
  'NEXT': VK_NEXT,
  'END': VK_END,
  'HOME': VK_HOME,
  'LEFT': VK_LEFT,
  'UP': VK_UP,
  'RIGHT': VK_RIGHT,
  'DOWN': VK_DOWN,
  'SELECT': VK_SELECT,
  'PRINT': VK_PRINT,
  'EXECUTE': VK_EXECUTE,
  'SNAPSHOT': VK_SNAPSHOT,
  'INSERT': VK_INSERT,
  'DELETE': VK_DELETE,
  'HELP': VK_HELP,
  'WIN': VK_LWIN,
  'LWIN': VK_LWIN,
  'RWIN': VK_RWIN,
  'APPS': VK_APPS,
  'SLEEP': VK_SLEEP,
  'N0': VK_NUMPAD0,
  'N1': VK_NUMPAD1,
  'N2': VK_NUMPAD2,
  'N3': VK_NUMPAD3,
  'N4': VK_NUMPAD4,
  'N5': VK_NUMPAD5,
  'N6': VK_NUMPAD6,
  'N7': VK_NUMPAD7,
  'N8': VK_NUMPAD8,
  'N9': VK_NUMPAD9,
  '*': VK_MULTIPLY,
  '+': VK_ADD,
  ',': VK_SEPARATOR,
  '-': VK_SUBTRACT,
  '.': VK_DECIMAL,
  '/': VK_DIVIDE,
  ';': VK_OEM_1,
  '=': VK_OEM_PLUS,
};

Map<int, String> _vKToKey = _keyToVK.map((k, v) => MapEntry(v, k));

int keyToVK(String key) {
  key = key.toUpperCase();

  if (_keyToVK.containsKey(key)) {
    return _keyToVK[key]!;
  }

  throw Exception('Invalid key: $key');
}

String vkToKey(int vk) {
  if (_vKToKey.containsKey(vk)) {
    return _vKToKey[vk]!;
  }

  throw Exception('Invalid VK: $vk');
}
