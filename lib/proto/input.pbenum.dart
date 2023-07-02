//
//  Generated code. Do not modify.
//  source: input.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Key_KeyActionType extends $pb.ProtobufEnum {
  static const Key_KeyActionType UP = Key_KeyActionType._(0, _omitEnumNames ? '' : 'UP');
  static const Key_KeyActionType DOWN = Key_KeyActionType._(1, _omitEnumNames ? '' : 'DOWN');
  static const Key_KeyActionType PRESS = Key_KeyActionType._(3, _omitEnumNames ? '' : 'PRESS');

  static const $core.List<Key_KeyActionType> values = <Key_KeyActionType> [
    UP,
    DOWN,
    PRESS,
  ];

  static final $core.Map<$core.int, Key_KeyActionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Key_KeyActionType? valueOf($core.int value) => _byValue[value];

  const Key_KeyActionType._($core.int v, $core.String n) : super(v, n);
}

class MouseKey_KeyActionType extends $pb.ProtobufEnum {
  static const MouseKey_KeyActionType UP = MouseKey_KeyActionType._(0, _omitEnumNames ? '' : 'UP');
  static const MouseKey_KeyActionType DOWN = MouseKey_KeyActionType._(1, _omitEnumNames ? '' : 'DOWN');
  static const MouseKey_KeyActionType PRESS = MouseKey_KeyActionType._(3, _omitEnumNames ? '' : 'PRESS');

  static const $core.List<MouseKey_KeyActionType> values = <MouseKey_KeyActionType> [
    UP,
    DOWN,
    PRESS,
  ];

  static final $core.Map<$core.int, MouseKey_KeyActionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MouseKey_KeyActionType? valueOf($core.int value) => _byValue[value];

  const MouseKey_KeyActionType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
