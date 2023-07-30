//
//  Generated code. Do not modify.
//  source: input.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'input.pb.dart' as $0;

export 'input.pb.dart';

@$pb.GrpcServiceName('InputMethods')
class InputMethodsClient extends $grpc.Client {
  static final _$pressKey = $grpc.ClientMethod<$0.Key, $0.Response>(
      '/InputMethods/PressKey',
      ($0.Key value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Response.fromBuffer(value));
  static final _$pressMouseKey = $grpc.ClientMethod<$0.MouseKey, $0.Response>(
      '/InputMethods/PressMouseKey',
      ($0.MouseKey value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Response.fromBuffer(value));
  static final _$moveMouse = $grpc.ClientMethod<$0.MouseMove, $0.Response>(
      '/InputMethods/MoveMouse',
      ($0.MouseMove value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Response.fromBuffer(value));
  static final _$ping = $grpc.ClientMethod<$0.Empty, $0.Response>(
      '/InputMethods/Ping',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Response.fromBuffer(value));
  static final _$setConfig = $grpc.ClientMethod<$0.Config, $0.Config>(
      '/InputMethods/SetConfig',
      ($0.Config value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Config.fromBuffer(value));
  static final _$getConfig = $grpc.ClientMethod<$0.Empty, $0.Config>(
      '/InputMethods/GetConfig',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Config.fromBuffer(value));

  InputMethodsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.Response> pressKey($0.Key request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pressKey, request, options: options);
  }

  $grpc.ResponseFuture<$0.Response> pressMouseKey($0.MouseKey request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pressMouseKey, request, options: options);
  }

  $grpc.ResponseFuture<$0.Response> moveMouse($0.MouseMove request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$moveMouse, request, options: options);
  }

  $grpc.ResponseFuture<$0.Response> ping($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  $grpc.ResponseFuture<$0.Config> setConfig($0.Config request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.Config> getConfig($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getConfig, request, options: options);
  }
}

@$pb.GrpcServiceName('InputMethods')
abstract class InputMethodsServiceBase extends $grpc.Service {
  $core.String get $name => 'InputMethods';

  InputMethodsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Key, $0.Response>(
        'PressKey',
        pressKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Key.fromBuffer(value),
        ($0.Response value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MouseKey, $0.Response>(
        'PressMouseKey',
        pressMouseKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MouseKey.fromBuffer(value),
        ($0.Response value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MouseMove, $0.Response>(
        'MoveMouse',
        moveMouse_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MouseMove.fromBuffer(value),
        ($0.Response value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Response>(
        'Ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Response value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Config, $0.Config>(
        'SetConfig',
        setConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Config.fromBuffer(value),
        ($0.Config value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Config>(
        'GetConfig',
        getConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Config value) => value.writeToBuffer()));
  }

  $async.Future<$0.Response> pressKey_Pre($grpc.ServiceCall call, $async.Future<$0.Key> request) async {
    return pressKey(call, await request);
  }

  $async.Future<$0.Response> pressMouseKey_Pre($grpc.ServiceCall call, $async.Future<$0.MouseKey> request) async {
    return pressMouseKey(call, await request);
  }

  $async.Future<$0.Response> moveMouse_Pre($grpc.ServiceCall call, $async.Future<$0.MouseMove> request) async {
    return moveMouse(call, await request);
  }

  $async.Future<$0.Response> ping_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return ping(call, await request);
  }

  $async.Future<$0.Config> setConfig_Pre($grpc.ServiceCall call, $async.Future<$0.Config> request) async {
    return setConfig(call, await request);
  }

  $async.Future<$0.Config> getConfig_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getConfig(call, await request);
  }

  $async.Future<$0.Response> pressKey($grpc.ServiceCall call, $0.Key request);
  $async.Future<$0.Response> pressMouseKey($grpc.ServiceCall call, $0.MouseKey request);
  $async.Future<$0.Response> moveMouse($grpc.ServiceCall call, $0.MouseMove request);
  $async.Future<$0.Response> ping($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Config> setConfig($grpc.ServiceCall call, $0.Config request);
  $async.Future<$0.Config> getConfig($grpc.ServiceCall call, $0.Empty request);
}
