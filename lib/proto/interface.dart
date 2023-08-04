import 'package:flutter/widgets.dart';

import '../proto/input.pbgrpc.dart' as pb;

enum ServerStatus { online, offline }

enum ClientStatus { connected, disconnected, connecting }

@immutable
class KeyOptions {
  final bool? noRepeat;
  final bool? unshiftOnRelease;
  // Interval in milliseconds between key repeats
  final int? keyRepeatInterval;
  // TODO: implement modifiers
  final List<int>? modifiers;
  // TODO: implement disableUnwantedModifiers
  // disables all modifiers except the ones specified in the modifiers list,
  // then enable them back when the key is released
  final bool? disableUnwantedModifiers;
  final bool isVirtual;

  const KeyOptions({
    this.noRepeat,
    this.unshiftOnRelease,
    this.keyRepeatInterval,
    this.modifiers,
    this.disableUnwantedModifiers,
    this.isVirtual = false,
  });

  factory KeyOptions.fromPb(pb.KeyOptions options) {
    return KeyOptions(
      noRepeat: options.noRepeat,
      disableUnwantedModifiers: options.noModifiers,
    );
  }

  pb.KeyOptions toPb() {
    return pb.KeyOptions()
      ..noRepeat = noRepeat ?? false
      ..noModifiers = disableUnwantedModifiers ?? false;
  }

  @override
  String toString() {
    return 'KeyOptions(noRepeat: $noRepeat, unshiftOnRelease: $unshiftOnRelease)';
  }
}

@immutable
class HotkeyOptions {
  final bool? unshiftOnRelease;
  final bool? disableUnwantedModifiers;
  final int? speed;

  const HotkeyOptions({
    this.unshiftOnRelease,
    this.disableUnwantedModifiers,
    this.speed,
  });

  factory HotkeyOptions.fromPb(pb.HotkeyOptions options) {
    return HotkeyOptions(
      speed: options.speed,
      disableUnwantedModifiers: options.noModifiers,
    );
  }

  pb.HotkeyOptions toPb() {
    return pb.HotkeyOptions()
      ..speed = speed ?? 0
      ..noModifiers = disableUnwantedModifiers ?? false;
  }

  @override
  String toString() {
    return 'HotkeyOptions(unshiftOnRelease: $unshiftOnRelease, disableUnwantedModifiers: $disableUnwantedModifiers, speed: $speed)';
  }
}

/// Base class for protobuf input clients
abstract class BasePbInputClient {
  ClientStatus get status;

  Future<pb.Response> pressKey(pb.Key key);
  Future<pb.Response> pressHotkey(pb.Hotkey hotkey);
  Future<pb.Response> moveMouse(pb.MouseMove mouseMove);
  Future<pb.Response> pressMouseKey(pb.MouseKey mouseKey);
  Future<pb.Config> getConfig();
  Future<pb.Config> setConfig(pb.Config config);
  Future<pb.Response> ping();
}
