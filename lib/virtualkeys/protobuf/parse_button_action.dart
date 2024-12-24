// Virtual keys
import 'package:remotecontrol_lib/proto/input.pbgrpc.dart' as pb;
import '../key.dart';

Map<ButtonActionType, pb.MouseKey_KeyActionType> _buttonActionTypeStateToPb = {
  ButtonActionType.UP: pb.MouseKey_KeyActionType.UP,
  ButtonActionType.DOWN: pb.MouseKey_KeyActionType.DOWN,
  ButtonActionType.PRESS: pb.MouseKey_KeyActionType.PRESS
};
Map<pb.MouseKey_KeyActionType, ButtonActionType> _pbToButtonActionType =
_buttonActionTypeStateToPb.map((k, v) => MapEntry(v, k));

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
