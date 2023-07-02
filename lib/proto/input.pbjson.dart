//
//  Generated code. Do not modify.
//  source: input.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use keyOptionsDescriptor instead')
const KeyOptions$json = {
  '1': 'KeyOptions',
  '2': [
    {'1': 'no_repeat', '3': 1, '4': 1, '5': 8, '9': 0, '10': 'noRepeat', '17': true},
  ],
  '8': [
    {'1': '_no_repeat'},
  ],
};

/// Descriptor for `KeyOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyOptionsDescriptor = $convert.base64Decode(
    'CgpLZXlPcHRpb25zEiAKCW5vX3JlcGVhdBgBIAEoCEgAUghub1JlcGVhdIgBAUIMCgpfbm9fcm'
    'VwZWF0');

@$core.Deprecated('Use keyDescriptor instead')
const Key$json = {
  '1': 'Key',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.Key.KeyActionType', '10': 'type'},
    {'1': 'options', '3': 3, '4': 1, '5': 11, '6': '.KeyOptions', '9': 0, '10': 'options', '17': true},
  ],
  '4': [Key_KeyActionType$json],
  '8': [
    {'1': '_options'},
  ],
};

@$core.Deprecated('Use keyDescriptor instead')
const Key_KeyActionType$json = {
  '1': 'KeyActionType',
  '2': [
    {'1': 'UP', '2': 0},
    {'1': 'DOWN', '2': 1},
    {'1': 'PRESS', '2': 3},
  ],
};

/// Descriptor for `Key`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyDescriptor = $convert.base64Decode(
    'CgNLZXkSDgoCaWQYASABKAVSAmlkEiYKBHR5cGUYAiABKA4yEi5LZXkuS2V5QWN0aW9uVHlwZV'
    'IEdHlwZRIqCgdvcHRpb25zGAMgASgLMgsuS2V5T3B0aW9uc0gAUgdvcHRpb25ziAEBIiwKDUtl'
    'eUFjdGlvblR5cGUSBgoCVVAQABIICgRET1dOEAESCQoFUFJFU1MQA0IKCghfb3B0aW9ucw==');

@$core.Deprecated('Use mouseKeyDescriptor instead')
const MouseKey$json = {
  '1': 'MouseKey',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.MouseKey.KeyActionType', '10': 'type'},
  ],
  '4': [MouseKey_KeyActionType$json],
};

@$core.Deprecated('Use mouseKeyDescriptor instead')
const MouseKey_KeyActionType$json = {
  '1': 'KeyActionType',
  '2': [
    {'1': 'UP', '2': 0},
    {'1': 'DOWN', '2': 1},
    {'1': 'PRESS', '2': 3},
  ],
};

/// Descriptor for `MouseKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseKeyDescriptor = $convert.base64Decode(
    'CghNb3VzZUtleRIOCgJpZBgBIAEoBVICaWQSKwoEdHlwZRgCIAEoDjIXLk1vdXNlS2V5LktleU'
    'FjdGlvblR5cGVSBHR5cGUiLAoNS2V5QWN0aW9uVHlwZRIGCgJVUBAAEggKBERPV04QARIJCgVQ'
    'UkVTUxAD');

@$core.Deprecated('Use mouseMoveDescriptor instead')
const MouseMove$json = {
  '1': 'MouseMove',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
    {'1': 'relative', '3': 3, '4': 1, '5': 8, '10': 'relative'},
  ],
};

/// Descriptor for `MouseMove`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseMoveDescriptor = $convert.base64Decode(
    'CglNb3VzZU1vdmUSDAoBeBgBIAEoAlIBeBIMCgF5GAIgASgCUgF5EhoKCHJlbGF0aXZlGAMgAS'
    'gIUghyZWxhdGl2ZQ==');

@$core.Deprecated('Use responseDescriptor instead')
const Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDescriptor = $convert.base64Decode(
    'CghSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use configDescriptor instead')
const Config$json = {
  '1': 'Config',
  '2': [
    {'1': 'cursor_speed', '3': 1, '4': 1, '5': 2, '9': 0, '10': 'cursorSpeed', '17': true},
    {'1': 'cursor_acceleration', '3': 2, '4': 1, '5': 2, '9': 1, '10': 'cursorAcceleration', '17': true},
  ],
  '8': [
    {'1': '_cursor_speed'},
    {'1': '_cursor_acceleration'},
  ],
};

/// Descriptor for `Config`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List configDescriptor = $convert.base64Decode(
    'CgZDb25maWcSJgoMY3Vyc29yX3NwZWVkGAEgASgCSABSC2N1cnNvclNwZWVkiAEBEjQKE2N1cn'
    'Nvcl9hY2NlbGVyYXRpb24YAiABKAJIAVISY3Vyc29yQWNjZWxlcmF0aW9uiAEBQg8KDV9jdXJz'
    'b3Jfc3BlZWRCFgoUX2N1cnNvcl9hY2NlbGVyYXRpb24=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

