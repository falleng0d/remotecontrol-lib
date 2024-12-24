enum KeyState { UP, DOWN }

// region Key Actions

enum KeyActionType { UP, DOWN, PRESS }

enum ButtonActionType { UP, DOWN, PRESS, MOVE }

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

// endregion

// region Key

/// {@category enum}
extension type const Key(int _) implements int {
  static const KEY_0 = 0;
  static const KEY_1 = 1;
  static const KEY_2 = 2;
  static const KEY_3 = 3;
  static const KEY_4 = 4;
  static const KEY_5 = 5;
  static const KEY_6 = 6;
  static const KEY_7 = 7;
  static const KEY_8 = 8;
  static const KEY_9 = 9;
  static const KEY_A = 10;
  static const KEY_B = 11;
  static const KEY_C = 12;
  static const KEY_D = 13;
  static const KEY_E = 14;
  static const KEY_F = 15;
  static const KEY_G = 16;
  static const KEY_H = 17;
  static const KEY_I = 18;
  static const KEY_J = 19;
  static const KEY_K = 20;
  static const KEY_L = 21;
  static const KEY_M = 22;
  static const KEY_N = 23;
  static const KEY_O = 24;
  static const KEY_P = 25;
  static const KEY_Q = 26;
  static const KEY_R = 27;
  static const KEY_S = 28;
  static const KEY_T = 29;
  static const KEY_U = 30;
  static const KEY_V = 31;
  static const KEY_W = 32;
  static const KEY_X = 33;
  static const KEY_Y = 34;
  static const KEY_Z = 35;
  static const KEY_F1 = 36;
  static const KEY_F2 = 37;
  static const KEY_F3 = 38;
  static const KEY_F4 = 39;
  static const KEY_F5 = 40;
  static const KEY_F6 = 41;
  static const KEY_F7 = 42;
  static const KEY_F8 = 43;
  static const KEY_F9 = 44;
  static const KEY_F10 = 45;
  static const KEY_F11 = 46;
  static const KEY_F12 = 47;
  static const KEY_NUMLOCK = 48;
  static const KEY_SCROLL = 49;
  static const KEY_BACK = 50;
  static const KEY_TAB = 51;
  static const KEY_RETURN = 52;
  static const KEY_LSHIFT = 53;
  static const KEY_RSHIFT = 54;
  static const KEY_LCONTROL = 55;
  static const KEY_RCONTROL = 56;
  static const KEY_LMENU = 57;
  static const KEY_RMENU = 58;
  static const KEY_CAPITAL = 59;
  static const KEY_ESCAPE = 60;
  static const KEY_CONVERT = 61;
  static const KEY_NONCONVERT = 62;
  static const KEY_ACCEPT = 63;
  static const KEY_MODECHANGE = 64;
  static const KEY_SPACE = 65;
  static const KEY_PRIOR = 66;
  static const KEY_NEXT = 67;
  static const KEY_END = 68;
  static const KEY_HOME = 69;
  static const KEY_LEFT = 70;
  static const KEY_UP = 71;
  static const KEY_RIGHT = 72;
  static const KEY_DOWN = 73;
  static const KEY_SELECT = 74;
  static const KEY_PRINT = 75;
  static const KEY_EXECUTE = 76;
  static const KEY_SNAPSHOT = 77;
  static const KEY_INSERT = 78;
  static const KEY_DELETE = 79;
  static const KEY_HELP = 80;
  static const KEY_LSUPER = 81;
  static const KEY_RSUPER = 82;
  static const KEY_APPS = 83;
  static const KEY_SLEEP = 84;
  static const KEY_NUMPAD0 = 85;
  static const KEY_NUMPAD1 = 86;
  static const KEY_NUMPAD2 = 87;
  static const KEY_NUMPAD3 = 88;
  static const KEY_NUMPAD4 = 89;
  static const KEY_NUMPAD5 = 90;
  static const KEY_NUMPAD6 = 91;
  static const KEY_NUMPAD7 = 92;
  static const KEY_NUMPAD8 = 93;
  static const KEY_NUMPAD9 = 94;
  static const KEY_MULTIPLY = 95; // *
  static const KEY_ADD = 96; // +
  static const KEY_SEPARATOR = 97; // =
  static const KEY_SUBTRACT = 98; // -
  static const KEY_DECIMAL = 99; // .
  static const KEY_DIVIDE = 100; // /
  static const KEY_OEM_PLUS = 101; // +=
  static const KEY_OEM_COMMA = 102; // ,<
  static const KEY_OEM_MINUS = 103; // -_
  static const KEY_OEM_PERIOD = 104; // .>
  static const KEY_OEM_1_SEMICOLON = 105; // :;
  static const KEY_OEM_2_FORWARD_SLASH = 106; // /?
  static const KEY_OEM_3_BACKTICK = 107; // `~
  static const KEY_OEM_4_SQUARE_BRACKET_OPEN = 108; // [{
  static const KEY_OEM_5_BACKSLASH = 109; // \|
  static const KEY_OEM_6_SQUARE_BRACKET_CLOSE = 110; // }]
  static const KEY_OEM_7_SINGLE_QUOTE = 111; // '"
  static const KEY_MEDIA_PLAY_PAUSE = 112;
  static const KEY_MEDIA_PREV_TRACK = 113;
  static const KEY_MEDIA_NEXT_TRACK = 114;
  static const KEY_VOLUME_MUTE = 115;
  static const KEY_VOLUME_UP = 116;
  static const KEY_VOLUME_DOWN = 117;
  static const KEY_MEDIA_STOP = 118;
  static const KEY_BROWSER_BACK = 119;
  static const KEY_BROWSER_FORWARD = 120;
  static const KEY_BROWSER_REFRESH = 121;
}

// endregion
