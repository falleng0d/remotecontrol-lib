import 'package:flutter/widgets.dart';

import '../proto/input.pbgrpc.dart' as pb;

enum ServerStatus { online, offline }

enum ClientStatus { connected, disconnected, connecting }

@immutable
class KeyOptions {
  final bool? noRepeat;
  final bool? unshiftOnRelease;

  const KeyOptions({this.noRepeat, this.unshiftOnRelease});

  factory KeyOptions.fromPb(pb.KeyOptions options) {
    return KeyOptions(
      noRepeat: options.noRepeat,
    );
  }

  @override
  String toString() {
    return 'KeyOptions(noRepeat: $noRepeat, unshiftOnRelease: $unshiftOnRelease)';
  }
}

/// Base class for protobuf input clients
abstract class BasePbInputClient {
  ClientStatus get status;

  Future<pb.Response> pressKey(pb.Key key);
  Future<pb.Response> moveMouse(pb.MouseMove mouseMove);
  Future<pb.Response> pressMouseKey(pb.MouseKey mouseKey);
  Future<pb.Config> getConfig();
  Future<pb.Config> setConfig(pb.Config config);
  Future<pb.Response> ping();
}
