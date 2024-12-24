// Virtual keys
import 'package:remotecontrol_lib/proto/input.pbgrpc.dart' as pb;
import '../key.dart';

Map<KeyActionType, pb.KeyActionType> _keyActionTypeToPb = {
  KeyActionType.UP: pb.KeyActionType.UP,
  KeyActionType.DOWN: pb.KeyActionType.DOWN,
  KeyActionType.PRESS: pb.KeyActionType.PRESS
};
Map<pb.KeyActionType, KeyActionType> _pbToKeyActionType =
_keyActionTypeToPb.map((k, v) => MapEntry(v, k));

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
