import 'package:remotecontrol_lib/utils/map.dart';

import 'exceptions.dart';
import 'key.dart';

/// [KeyStringMapper] is an abstract class that provides a mapping between
/// strings and key codes.
abstract base class KeyStringMapper {
  const KeyStringMapper();

  int stringToKey(String key) => throw UnimplementedError();

  String keyToString(int key) => throw UnimplementedError();

  stringToShiftedString(String key) => throw UnimplementedError();

  bool isModifierKey(int key) => throw UnimplementedError();

  bool isModifierKeyByName(String key) => throw UnimplementedError();

  List<int> getModifierKeys() => throw UnimplementedError();
}

/// [EnIntlKeyStringMapper] is a concrete implementation of [KeyStringMapper]. It
/// provides a mapping between strings and key codes for the English
/// International (en-INTL) layout.
final class EnIntlKeyStringMapper extends KeyStringMapper {
  static const Map<String, int> _stringToKey = {
    '0': Key.KEY_0,
    '1': Key.KEY_1,
    '2': Key.KEY_2,
    '3': Key.KEY_3,
    '4': Key.KEY_4,
    '5': Key.KEY_5,
    '6': Key.KEY_6,
    '7': Key.KEY_7,
    '8': Key.KEY_8,
    '9': Key.KEY_9,
    'A': Key.KEY_A,
    'B': Key.KEY_B,
    'C': Key.KEY_C,
    'D': Key.KEY_D,
    'E': Key.KEY_E,
    'F': Key.KEY_F,
    'G': Key.KEY_G,
    'H': Key.KEY_H,
    'I': Key.KEY_I,
    'J': Key.KEY_J,
    'K': Key.KEY_K,
    'L': Key.KEY_L,
    'M': Key.KEY_M,
    'N': Key.KEY_N,
    'O': Key.KEY_O,
    'P': Key.KEY_P,
    'Q': Key.KEY_Q,
    'R': Key.KEY_R,
    'S': Key.KEY_S,
    'T': Key.KEY_T,
    'U': Key.KEY_U,
    'V': Key.KEY_V,
    'W': Key.KEY_W,
    'X': Key.KEY_X,
    'Y': Key.KEY_Y,
    'Z': Key.KEY_Z,
    'F1': Key.KEY_F1,
    'F2': Key.KEY_F2,
    'F3': Key.KEY_F3,
    'F4': Key.KEY_F4,
    'F5': Key.KEY_F5,
    'F6': Key.KEY_F6,
    'F7': Key.KEY_F7,
    'F8': Key.KEY_F8,
    'F9': Key.KEY_F9,
    'F10': Key.KEY_F10,
    'F11': Key.KEY_F11,
    'F12': Key.KEY_F12,
    'NUMLOCK': Key.KEY_NUMLOCK,
    'SCROLLLOCK': Key.KEY_SCROLL,
    'BACKSPACE': Key.KEY_BACK,
    'TAB': Key.KEY_TAB,
    'ENTER': Key.KEY_RETURN,
    'SHIFT': Key.KEY_LSHIFT,
    'LSHIFT': Key.KEY_LSHIFT,
    'RSHIFT': Key.KEY_RSHIFT,
    'CTRL': Key.KEY_LCONTROL,
    'LCTRL': Key.KEY_LCONTROL,
    'RCTRL': Key.KEY_RCONTROL,
    'ALT': Key.KEY_LMENU,
    'LALT': Key.KEY_LMENU,
    'RALT': Key.KEY_RMENU,
    'CAPITAL': Key.KEY_CAPITAL,
    'ESCAPE': Key.KEY_ESCAPE,
    'CONVERT': Key.KEY_CONVERT,
    'NONCONVERT': Key.KEY_NONCONVERT,
    'ACCEPT': Key.KEY_ACCEPT,
    'MODECHANGE': Key.KEY_MODECHANGE,
    'SPACE': Key.KEY_SPACE,
    'PRIOR': Key.KEY_PRIOR,
    'NEXT': Key.KEY_NEXT,
    'END': Key.KEY_END,
    'HOME': Key.KEY_HOME,
    'LEFT': Key.KEY_LEFT,
    'UP': Key.KEY_UP,
    'RIGHT': Key.KEY_RIGHT,
    'DOWN': Key.KEY_DOWN,
    'SELECT': Key.KEY_SELECT,
    'PRINT': Key.KEY_PRINT,
    'EXECUTE': Key.KEY_EXECUTE,
    'SNAPSHOT': Key.KEY_SNAPSHOT,
    'INSERT': Key.KEY_INSERT,
    'DELETE': Key.KEY_DELETE,
    'HELP': Key.KEY_HELP,
    'WIN': Key.KEY_LSUPER,
    'CMD': Key.KEY_LSUPER,
    'SUPER': Key.KEY_LSUPER,
    'LWIN': Key.KEY_LSUPER,
    'LCMD': Key.KEY_LSUPER,
    'LSUPER': Key.KEY_LSUPER,
    'RWIN': Key.KEY_RSUPER,
    'RCMD': Key.KEY_RSUPER,
    'RSUPER': Key.KEY_RSUPER,
    'APPS': Key.KEY_APPS,
    'SLEEP': Key.KEY_SLEEP,
    'PGUP': Key.KEY_PRIOR,
    'PGDOWN': Key.KEY_NEXT,
    'N0': Key.KEY_NUMPAD0,
    'N1': Key.KEY_NUMPAD1,
    'N2': Key.KEY_NUMPAD2,
    'N3': Key.KEY_NUMPAD3,
    'N4': Key.KEY_NUMPAD4,
    'N5': Key.KEY_NUMPAD5,
    'N6': Key.KEY_NUMPAD6,
    'N7': Key.KEY_NUMPAD7,
    'N8': Key.KEY_NUMPAD8,
    'N9': Key.KEY_NUMPAD9,
    '*': Key.KEY_MULTIPLY,
    '+': Key.KEY_ADD,
    '=': Key.KEY_OEM_PLUS,
    ',': Key.KEY_OEM_COMMA,
    '-': Key.KEY_OEM_MINUS,
    '_': Key.KEY_OEM_MINUS, // Shift + -
    '.': Key.KEY_OEM_PERIOD,
    ';': Key.KEY_OEM_1_SEMICOLON,
    '/': Key.KEY_OEM_2_FORWARD_SLASH,
    '?': Key.KEY_OEM_2_FORWARD_SLASH, // Shift + /
    '`': Key.KEY_OEM_3_BACKTICK,
    '[': Key.KEY_OEM_4_SQUARE_BRACKET_OPEN,
    '\\': Key.KEY_OEM_5_BACKSLASH,
    ']': Key.KEY_OEM_6_SQUARE_BRACKET_CLOSE,
    '\'': Key.KEY_OEM_7_SINGLE_QUOTE,
    '"': Key.KEY_OEM_7_SINGLE_QUOTE, // Shift + '
    '!': Key.KEY_1, // Shift + 1
    'MEDIA_PLAY': Key.KEY_MEDIA_PLAY_PAUSE,
    'MEDIA_PREVIOUS': Key.KEY_MEDIA_PREV_TRACK,
    'MEDIA_NEXT': Key.KEY_MEDIA_NEXT_TRACK,
    'MEDIA_MUTE': Key.KEY_VOLUME_MUTE,
    'MEDIA_VOLUME_UP': Key.KEY_VOLUME_UP,
    'MEDIA_VOLUME_DOWN': Key.KEY_VOLUME_DOWN,
    'MEDIA_STOP': Key.KEY_MEDIA_STOP,
    'MEDIA_BACK': Key.KEY_BROWSER_BACK,
    'MEDIA_FORWARD': Key.KEY_BROWSER_FORWARD,
    'MEDIA_REFRESH': Key.KEY_BROWSER_REFRESH,
  };

  static final Map<int, String> _keyToString = _stringToKey.invertNoOverrideDuplicate();

  static const List<int> _modifiers = [
    Key.KEY_LSHIFT,
    Key.KEY_RSHIFT,
    Key.KEY_LCONTROL,
    Key.KEY_RCONTROL,
    Key.KEY_LMENU,
    Key.KEY_RMENU,
    Key.KEY_LSUPER,
    Key.KEY_RSUPER,
  ];

  const EnIntlKeyStringMapper();

  @override int stringToKey(String key) {
    key = key.toUpperCase();

    if (_stringToKey.containsKey(key)) {
      return _stringToKey[key]!;
    }

    throw InvalidKeyException('No String for key: $key');
  }

  @override String keyToString(int key) {
    if (_keyToString.containsKey(key)) {
      return _keyToString[key]!;
    }

    throw InvalidKeyException('No key for String: $key');
  }

  @override stringToShiftedString(String key) {
    switch (key) {
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
        return key.toUpperCase();
    }
  }

  @override bool isModifierKey(int key) => _modifiers.contains(key);

  @override bool isModifierKeyByName(String key) => _modifiers.contains(stringToKey(key));

  @override List<int> getModifierKeys() => _modifiers;
}

enum Locality {
  enINTL,
}

const KeyMappers = <Locality, KeyStringMapper>{
  Locality.enINTL: EnIntlKeyStringMapper(),
};

KeyStringMapper getKeyMapper<T extends KeyStringMapper>(Locality locality) {
  if (KeyMappers.containsKey(locality)) {
    return KeyMappers[locality]!;
  }

  throw InvalidKeyException('No key mapper for locality: $locality');
}

const DEFAULT_LOCALITY = Locality.enINTL;

String keyToString(int key, [Locality locality = DEFAULT_LOCALITY]) {
  return getKeyMapper(locality).keyToString(key);
}

int stringToKey(String key, [Locality locality = DEFAULT_LOCALITY]) {
  return getKeyMapper(locality).stringToKey(key);
}

String stringToShiftedKeyString(String key, [Locality locality = DEFAULT_LOCALITY]) {
  return getKeyMapper(locality).stringToShiftedString(key);
}

bool isModifierKey(int key, [Locality locality = DEFAULT_LOCALITY]) {
  return getKeyMapper(locality).isModifierKey(key);
}

bool isModifierKeyByName(String key, [Locality locality = DEFAULT_LOCALITY]) {
  return getKeyMapper(locality).isModifierKeyByName(key);
}
