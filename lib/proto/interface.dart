import '../proto/input.pbgrpc.dart' as pb;

enum ServerStatus { online, offline }

enum ClientStatus { connected, disconnected }

enum MouseKeys { left, right, middle }

/// Base class for protobuf input clients
abstract class BasePbInputClientController {
  ClientStatus get status;

  Future<pb.Response> pressKey(pb.Key key);
  Future<pb.Response> moveMouse(pb.MouseMove mouseMove);
  Future<pb.Response> pressMouseKey(pb.MouseKey mouseKey);
  Future<pb.Response> ping();
}
