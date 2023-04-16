import '../proto/input.pbgrpc.dart' as pb;

enum ServerStatus { online, offline }

enum ClientStatus { connected, disconnected, connecting }

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
