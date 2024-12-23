// Virtual keys
import 'package:remotecontrol_lib/proto/input.pbgrpc.dart' as pb;
import 'key_action.dart';

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
