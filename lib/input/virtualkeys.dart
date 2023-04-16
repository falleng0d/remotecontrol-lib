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

class SystemKey {
  final int keyDown;
  final int keyUp;

  const SystemKey(this.keyDown, this.keyUp);

  // construct from MouseButton
  static SystemKey fromMouseButton(MouseButton button) {
    switch (button) {
      case MouseButton.LEFT:
        return MouseKeys.left;
      case MouseButton.RIGHT:
        return MouseKeys.right;
      case MouseButton.MIDDLE:
        return MouseKeys.middle;
    }
  }
}

const SK_MOUSE_LEFT = SystemKey(MOUSEEVENTF_LEFTDOWN, MOUSEEVENTF_LEFTUP);
const SK_MOUSE_RIGHT = SystemKey(MOUSEEVENTF_RIGHTDOWN, MOUSEEVENTF_RIGHTUP);
const SK_MOUSE_MIDDLE = SystemKey(MOUSEEVENTF_MIDDLEDOWN, MOUSEEVENTF_MIDDLEUP);

enum MouseButton { LEFT, RIGHT, MIDDLE }

class MouseKeys {
  static const left = SK_MOUSE_LEFT;
  static const right = SK_MOUSE_RIGHT;
  static const middle = SK_MOUSE_MIDDLE;

  // construct from MouseButton
  static SystemKey fromMouseButton(MouseButton button) {
    switch (button) {
      case MouseButton.LEFT:
        return left;
      case MouseButton.RIGHT:
        return right;
      case MouseButton.MIDDLE:
        return middle;
    }
  }
}

enum ActionType { UP, DOWN, PRESS }

enum MouseActionType { UP, DOWN, MOVE, PRESS }

enum KeyState { UP, DOWN }

class KBAction {
  final ActionType type;
  final int value;

  const KBAction(this.type, {this.value = 1});
}

class MBAction {
  final ActionType type;
  final double x;
  final double y;

  const MBAction(this.type, {this.x = 0, this.y = 0});
}
