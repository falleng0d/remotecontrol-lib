//
//  Generated code. Do not modify.
//  source: lib/proto/input.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'input.pbenum.dart';

export 'input.pbenum.dart';

class KeyOptions extends $pb.GeneratedMessage {
  factory KeyOptions({
    $core.bool? noRepeat,
    $core.bool? noModifiers,
    $core.Iterable<$core.int>? modifiers,
  }) {
    final $result = create();
    if (noRepeat != null) {
      $result.noRepeat = noRepeat;
    }
    if (noModifiers != null) {
      $result.noModifiers = noModifiers;
    }
    if (modifiers != null) {
      $result.modifiers.addAll(modifiers);
    }
    return $result;
  }
  KeyOptions._() : super();
  factory KeyOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'KeyOptions', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'noRepeat')
    ..aOB(2, _omitFieldNames ? '' : 'noModifiers')
    ..p<$core.int>(3, _omitFieldNames ? '' : 'modifiers', $pb.PbFieldType.K3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyOptions clone() => KeyOptions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyOptions copyWith(void Function(KeyOptions) updates) => super.copyWith((message) => updates(message as KeyOptions)) as KeyOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KeyOptions create() => KeyOptions._();
  KeyOptions createEmptyInstance() => create();
  static $pb.PbList<KeyOptions> createRepeated() => $pb.PbList<KeyOptions>();
  @$core.pragma('dart2js:noInline')
  static KeyOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyOptions>(create);
  static KeyOptions? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get noRepeat => $_getBF(0);
  @$pb.TagNumber(1)
  set noRepeat($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNoRepeat() => $_has(0);
  @$pb.TagNumber(1)
  void clearNoRepeat() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get noModifiers => $_getBF(1);
  @$pb.TagNumber(2)
  set noModifiers($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNoModifiers() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoModifiers() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get modifiers => $_getList(2);
}

/// The key message containing a key code and a state
class Key extends $pb.GeneratedMessage {
  factory Key({
    $core.int? id,
    KeyActionType? type,
    KeyOptions? options,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (type != null) {
      $result.type = type;
    }
    if (options != null) {
      $result.options = options;
    }
    return $result;
  }
  Key._() : super();
  factory Key.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Key.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Key', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..e<KeyActionType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: KeyActionType.UP, valueOf: KeyActionType.valueOf, enumValues: KeyActionType.values)
    ..aOM<KeyOptions>(3, _omitFieldNames ? '' : 'options', subBuilder: KeyOptions.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Key clone() => Key()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Key copyWith(void Function(Key) updates) => super.copyWith((message) => updates(message as Key)) as Key;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Key create() => Key._();
  Key createEmptyInstance() => create();
  static $pb.PbList<Key> createRepeated() => $pb.PbList<Key>();
  @$core.pragma('dart2js:noInline')
  static Key getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Key>(create);
  static Key? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  KeyActionType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(KeyActionType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  KeyOptions get options => $_getN(2);
  @$pb.TagNumber(3)
  set options(KeyOptions v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOptions() => $_has(2);
  @$pb.TagNumber(3)
  void clearOptions() => clearField(3);
  @$pb.TagNumber(3)
  KeyOptions ensureOptions() => $_ensure(2);
}

class HotkeyOptions extends $pb.GeneratedMessage {
  factory HotkeyOptions({
    $core.int? speed,
    $core.bool? noModifiers,
  }) {
    final $result = create();
    if (speed != null) {
      $result.speed = speed;
    }
    if (noModifiers != null) {
      $result.noModifiers = noModifiers;
    }
    return $result;
  }
  HotkeyOptions._() : super();
  factory HotkeyOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HotkeyOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HotkeyOptions', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'speed', $pb.PbFieldType.O3)
    ..aOB(2, _omitFieldNames ? '' : 'noModifiers')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HotkeyOptions clone() => HotkeyOptions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HotkeyOptions copyWith(void Function(HotkeyOptions) updates) => super.copyWith((message) => updates(message as HotkeyOptions)) as HotkeyOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HotkeyOptions create() => HotkeyOptions._();
  HotkeyOptions createEmptyInstance() => create();
  static $pb.PbList<HotkeyOptions> createRepeated() => $pb.PbList<HotkeyOptions>();
  @$core.pragma('dart2js:noInline')
  static HotkeyOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HotkeyOptions>(create);
  static HotkeyOptions? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get speed => $_getIZ(0);
  @$pb.TagNumber(1)
  set speed($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpeed() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpeed() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get noModifiers => $_getBF(1);
  @$pb.TagNumber(2)
  set noModifiers($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNoModifiers() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoModifiers() => clearField(2);
}

class Hotkey extends $pb.GeneratedMessage {
  factory Hotkey({
    $core.String? hotkey,
    KeyActionType? type,
    HotkeyOptions? options,
  }) {
    final $result = create();
    if (hotkey != null) {
      $result.hotkey = hotkey;
    }
    if (type != null) {
      $result.type = type;
    }
    if (options != null) {
      $result.options = options;
    }
    return $result;
  }
  Hotkey._() : super();
  factory Hotkey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Hotkey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Hotkey', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hotkey')
    ..e<KeyActionType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: KeyActionType.UP, valueOf: KeyActionType.valueOf, enumValues: KeyActionType.values)
    ..aOM<HotkeyOptions>(3, _omitFieldNames ? '' : 'options', subBuilder: HotkeyOptions.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Hotkey clone() => Hotkey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Hotkey copyWith(void Function(Hotkey) updates) => super.copyWith((message) => updates(message as Hotkey)) as Hotkey;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Hotkey create() => Hotkey._();
  Hotkey createEmptyInstance() => create();
  static $pb.PbList<Hotkey> createRepeated() => $pb.PbList<Hotkey>();
  @$core.pragma('dart2js:noInline')
  static Hotkey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Hotkey>(create);
  static Hotkey? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hotkey => $_getSZ(0);
  @$pb.TagNumber(1)
  set hotkey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHotkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearHotkey() => clearField(1);

  @$pb.TagNumber(2)
  KeyActionType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(KeyActionType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  HotkeyOptions get options => $_getN(2);
  @$pb.TagNumber(3)
  set options(HotkeyOptions v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOptions() => $_has(2);
  @$pb.TagNumber(3)
  void clearOptions() => clearField(3);
  @$pb.TagNumber(3)
  HotkeyOptions ensureOptions() => $_ensure(2);
}

class MouseKey extends $pb.GeneratedMessage {
  factory MouseKey({
    $core.int? id,
    MouseKey_KeyActionType? type,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (type != null) {
      $result.type = type;
    }
    return $result;
  }
  MouseKey._() : super();
  factory MouseKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MouseKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MouseKey', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..e<MouseKey_KeyActionType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: MouseKey_KeyActionType.UP, valueOf: MouseKey_KeyActionType.valueOf, enumValues: MouseKey_KeyActionType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MouseKey clone() => MouseKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MouseKey copyWith(void Function(MouseKey) updates) => super.copyWith((message) => updates(message as MouseKey)) as MouseKey;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MouseKey create() => MouseKey._();
  MouseKey createEmptyInstance() => create();
  static $pb.PbList<MouseKey> createRepeated() => $pb.PbList<MouseKey>();
  @$core.pragma('dart2js:noInline')
  static MouseKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MouseKey>(create);
  static MouseKey? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  MouseKey_KeyActionType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(MouseKey_KeyActionType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}

class MouseMove extends $pb.GeneratedMessage {
  factory MouseMove({
    $core.double? x,
    $core.double? y,
    $core.bool? relative,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (relative != null) {
      $result.relative = relative;
    }
    return $result;
  }
  MouseMove._() : super();
  factory MouseMove.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MouseMove.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MouseMove', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OF)
    ..aOB(3, _omitFieldNames ? '' : 'relative')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MouseMove clone() => MouseMove()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MouseMove copyWith(void Function(MouseMove) updates) => super.copyWith((message) => updates(message as MouseMove)) as MouseMove;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MouseMove create() => MouseMove._();
  MouseMove createEmptyInstance() => create();
  static $pb.PbList<MouseMove> createRepeated() => $pb.PbList<MouseMove>();
  @$core.pragma('dart2js:noInline')
  static MouseMove getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MouseMove>(create);
  static MouseMove? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get relative => $_getBF(2);
  @$pb.TagNumber(3)
  set relative($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRelative() => $_has(2);
  @$pb.TagNumber(3)
  void clearRelative() => clearField(3);
}

class Response extends $pb.GeneratedMessage {
  factory Response({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  Response._() : super();
  factory Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Response', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Response clone() => Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Response copyWith(void Function(Response) updates) => super.copyWith((message) => updates(message as Response)) as Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Response create() => Response._();
  Response createEmptyInstance() => create();
  static $pb.PbList<Response> createRepeated() => $pb.PbList<Response>();
  @$core.pragma('dart2js:noInline')
  static Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Response>(create);
  static Response? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class Config extends $pb.GeneratedMessage {
  factory Config({
    $core.double? cursorSpeed,
    $core.double? cursorAcceleration,
  }) {
    final $result = create();
    if (cursorSpeed != null) {
      $result.cursorSpeed = cursorSpeed;
    }
    if (cursorAcceleration != null) {
      $result.cursorAcceleration = cursorAcceleration;
    }
    return $result;
  }
  Config._() : super();
  factory Config.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Config.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Config', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'cursorSpeed', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'cursorAcceleration', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Config clone() => Config()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Config copyWith(void Function(Config) updates) => super.copyWith((message) => updates(message as Config)) as Config;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Config create() => Config._();
  Config createEmptyInstance() => create();
  static $pb.PbList<Config> createRepeated() => $pb.PbList<Config>();
  @$core.pragma('dart2js:noInline')
  static Config getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Config>(create);
  static Config? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get cursorSpeed => $_getN(0);
  @$pb.TagNumber(1)
  set cursorSpeed($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCursorSpeed() => $_has(0);
  @$pb.TagNumber(1)
  void clearCursorSpeed() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get cursorAcceleration => $_getN(1);
  @$pb.TagNumber(2)
  set cursorAcceleration($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCursorAcceleration() => $_has(1);
  @$pb.TagNumber(2)
  void clearCursorAcceleration() => clearField(2);
}

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();
  Empty._() : super();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Empty', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
