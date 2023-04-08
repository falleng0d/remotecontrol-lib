///
//  Generated code. Do not modify.
//  source: input.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Key_KeyActionType extends $pb.ProtobufEnum {
  static const Key_KeyActionType UP = Key_KeyActionType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UP');
  static const Key_KeyActionType DOWN = Key_KeyActionType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOWN');
  static const Key_KeyActionType PRESS = Key_KeyActionType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PRESS');

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
  static const MouseKey_KeyActionType UP = MouseKey_KeyActionType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UP');
  static const MouseKey_KeyActionType DOWN = MouseKey_KeyActionType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOWN');
  static const MouseKey_KeyActionType PRESS = MouseKey_KeyActionType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PRESS');

  static const $core.List<MouseKey_KeyActionType> values = <MouseKey_KeyActionType> [
    UP,
    DOWN,
    PRESS,
  ];

  static final $core.Map<$core.int, MouseKey_KeyActionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MouseKey_KeyActionType? valueOf($core.int value) => _byValue[value];

  const MouseKey_KeyActionType._($core.int v, $core.String n) : super(v, n);
}

