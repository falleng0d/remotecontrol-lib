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

enum MouseButton { LEFT, RIGHT, MIDDLE, X }

enum KeyAction { KEY_UP, KEY_DOWN, KEY_PRESS }

enum MouseAction { KEY_UP, KEY_DOWN, KEY_PRESS, CURSOR_MOVE }

enum KeyState { UP, DOWN }

@immutable
class MBWrapper {
  final int keyDown;
  final int keyUp;

  const MBWrapper(this.keyDown, this.keyUp);

  // construct from MouseButton
  static MBWrapper fromMouseButton(MouseButton button) {
    switch (button) {
      case MouseButton.LEFT:
        return MBWrapper(MOUSEEVENTF_LEFTDOWN, MOUSEEVENTF_LEFTUP);
      case MouseButton.RIGHT:
        return MBWrapper(MOUSEEVENTF_RIGHTDOWN, MOUSEEVENTF_RIGHTUP);
      case MouseButton.MIDDLE:
        return MBWrapper(MOUSEEVENTF_MIDDLEDOWN, MOUSEEVENTF_MIDDLEUP);
      case MouseButton.X:
        return MBWrapper(MOUSEEVENTF_XDOWN, MOUSEEVENTF_XUP);
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

int keyToVK(String key) {
  key = key.toUpperCase();
  switch (key) {
    case '0':
      return VK_0;
    case '1':
      return VK_1;
    case '2':
      return VK_2;
    case '3':
      return VK_3;
    case '4':
      return VK_4;
    case '5':
      return VK_5;
    case '6':
      return VK_6;
    case '7':
      return VK_7;
    case '8':
      return VK_8;
    case '9':
      return VK_9;
    case 'A':
      return VK_A;
    case 'B':
      return VK_B;
    case 'C':
      return VK_C;
    case 'D':
      return VK_D;
    case 'E':
      return VK_E;
    case 'F':
      return VK_F;
    case 'G':
      return VK_G;
    case 'H':
      return VK_H;
    case 'I':
      return VK_I;
    case 'J':
      return VK_J;
    case 'K':
      return VK_K;
    case 'L':
      return VK_L;
    case 'M':
      return VK_M;
    case 'N':
      return VK_N;
    case 'O':
      return VK_O;
    case 'P':
      return VK_P;
    case 'Q':
      return VK_Q;
    case 'R':
      return VK_R;
    case 'S':
      return VK_S;
    case 'T':
      return VK_T;
    case 'U':
      return VK_U;
    case 'V':
      return VK_V;
    case 'W':
      return VK_W;
    case 'X':
      return VK_X;
    case 'Y':
      return VK_Y;
    case 'Z':
      return VK_Z;
    case 'F1':
      return VK_F1;
    case 'F2':
      return VK_F2;
    case 'F3':
      return VK_F3;
    case 'F4':
      return VK_F4;
    case 'F5':
      return VK_F5;
    case 'F6':
      return VK_F6;
    case 'F7':
      return VK_F7;
    case 'F8':
      return VK_F8;
    case 'F9':
      return VK_F9;
    case 'F10':
      return VK_F10;
    case 'F11':
      return VK_F11;
    case 'F12':
      return VK_F12;
    case 'NUMLOCK':
      return VK_NUMLOCK;
    case 'SCROLLLOCK':
      return VK_SCROLL;
    case 'BACKSPACE':
      return VK_BACK;
    case 'TAB':
      return VK_TAB;
    case 'ENTER':
      return VK_RETURN;
    case 'SHIFT':
      return VK_SHIFT;
    case 'LSHIFT':
      return VK_LSHIFT;
    case 'RSHIFT':
      return VK_RSHIFT;
    case 'CTRL':
      return VK_CONTROL;
    case 'LCTRL':
      return VK_LCONTROL;
    case 'RCTRL':
      return VK_RCONTROL;
    case 'ALT':
      return VK_MENU;
    case 'LALT':
      return VK_LMENU;
    case 'RALT':
      return VK_RMENU;
    case 'CAPITAL':
      return VK_CAPITAL;
    case 'KANA':
      return VK_KANA;
    case 'HANGEUL':
      return VK_HANGEUL;
    case 'HANGUL':
      return VK_HANGUL;
    case 'JUNJA':
      return VK_JUNJA;
    case 'FINAL':
      return VK_FINAL;
    case 'HANJA':
      return VK_HANJA;
    case 'KANJI':
      return VK_KANJI;
    case 'ESCAPE':
      return VK_ESCAPE;
    case 'CONVERT':
      return VK_CONVERT;
    case 'NONCONVERT':
      return VK_NONCONVERT;
    case 'ACCEPT':
      return VK_ACCEPT;
    case 'MODECHANGE':
      return VK_MODECHANGE;
    case 'SPACE':
      return VK_SPACE;
    case 'PRIOR':
      return VK_PRIOR;
    case 'NEXT':
      return VK_NEXT;
    case 'END':
      return VK_END;
    case 'HOME':
      return VK_HOME;
    case 'LEFT':
      return VK_LEFT;
    case 'UP':
      return VK_UP;
    case 'RIGHT':
      return VK_RIGHT;
    case 'DOWN':
      return VK_DOWN;
    case 'SELECT':
      return VK_SELECT;
    case 'PRINT':
      return VK_PRINT;
    case 'EXECUTE':
      return VK_EXECUTE;
    case 'SNAPSHOT':
      return VK_SNAPSHOT;
    case 'INSERT':
      return VK_INSERT;
    case 'DELETE':
      return VK_DELETE;
    case 'HELP':
      return VK_HELP;
    case 'WIN':
      return VK_LWIN;
    case 'LWIN':
      return VK_LWIN;
    case 'RWIN':
      return VK_RWIN;
    case 'APPS':
      return VK_APPS;
    case 'SLEEP':
      return VK_SLEEP;
    case 'N0':
      return VK_NUMPAD0;
    case 'N1':
      return VK_NUMPAD1;
    case 'N2':
      return VK_NUMPAD2;
    case 'N3':
      return VK_NUMPAD3;
    case 'N4':
      return VK_NUMPAD4;
    case 'N5':
      return VK_NUMPAD5;
    case 'N6':
      return VK_NUMPAD6;
    case 'N7':
      return VK_NUMPAD7;
    case 'N8':
      return VK_NUMPAD8;
    case 'N9':
      return VK_NUMPAD9;
    case '*':
      return VK_MULTIPLY;
    case '+':
      return VK_ADD;
    case ',':
      return VK_SEPARATOR;
    case '-':
      return VK_SUBTRACT;
    case '.':
      return VK_DECIMAL;
    case '/':
      return VK_DIVIDE;
    default:
      return 0;
  }
}
