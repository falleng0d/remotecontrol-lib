import 'dart:io';

import 'package:flutter/widgets.dart' show BuildContext, Container, Widget;
import 'package:get/get.dart';
import 'package:remotecontrol_lib/input.dart';
import 'package:test/test.dart';

import '../action_contexts.dart';
import '../keyboard.dart';
import 'parser.dart';

class TestKeyElement extends BaseKeyElement {
  @override
  BaseAction action;
  @override
  BaseAction? doubleTapAction;

  @override
  double doubleTapThershold;
  @override
  BaseAction? holdAction;
  @override
  double holdTimeThreshold;

  @override
  double keyRep;
  @override
  double keyRepeatDelay;
  @override
  bool toggle;

  TestKeyElement({
    Geometry geometry = const Geometry(),
    String label = '',
    required this.action,
    this.doubleTapAction,
    this.doubleTapThershold = 0,
    this.holdAction,
    this.holdTimeThreshold = 0,
    this.keyRep = 0,
    this.keyRepeatDelay = 0,
    this.toggle = false,
  }) : super(action, geometry: geometry, label: label);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TestKeyElementFactory extends BaseKeyElementFactory {
  @override
  double doubleTapThershold;
  @override
  double holdTimeThreshold;
  @override
  double keyRep;
  @override
  double keyRepeatDelay;
  @override
  bool toggle;

  TestKeyElementFactory({
    required this.doubleTapThershold,
    required this.holdTimeThreshold,
    required this.keyRep,
    required this.keyRepeatDelay,
    required this.toggle,
    Geometry? geometry,
  }) : super(geometry);

  @override
  BaseKeyElement build(BaseAction action,
      {String? label, BaseAction? doubleTapAction, BaseAction? holdAction}) {
    return TestKeyElement(
      geometry: geometry,
      label: label ??= '',
      action: action,
      doubleTapAction: doubleTapAction,
      doubleTapThershold: doubleTapThershold,
      holdAction: holdAction,
      holdTimeThreshold: holdTimeThreshold,
      keyRep: keyRep,
      keyRepeatDelay: keyRepeatDelay,
      toggle: toggle,
    );
  }
}

class TestKeyAction extends BaseKeyAction {
  @override
  final int keyCode;

  const TestKeyAction(this.keyCode) : super(keyCode);

  @override
  Future<bool> doAction(ActionContext ctx) async {
    print('TestKeyAction.doAction: $keyCode');
    return true;
  }
}

class TestKeyActionFactory extends BaseKeyActionFactory {
  @override
  TestKeyAction build(String keyCode) {
    return TestKeyAction(keyToVK(keyCode));
  }
}

void main() {
  late String xmlContent;
  late VirtualKeyboardXMLParser parser;

  group('VirtualKeyboardXMLParser 1', () {
    setUp(() {
      xmlContent = File('lib/src/keyboard.xml').readAsStringSync();
      parser = VirtualKeyboardXMLParser(xmlContent);
    });

    test('getKeyboardName', () {
      expect(parser.getKeyboardName(), 'Split Keyboard');
    });

    test('getMenus', () {
      final menus = parser.getMenus();

      expect(menus.length, 1);
      expect(menus.first.getAttribute('id'), 'menu1');
    });

    test('getMenu', () {
      final menu = parser.getMenu('menu1');
      final keys = menu.childElements;

      expect(keys.length, 7);
      expect(keys.map((key) => key.text), ['á', 'ã', 'à', 'â', 'ä', 'å', 'æ']);
    });

    test('getMenuItems', () {
      final keys = parser.getMenuItems('menu1');

      expect(keys.length, 7);
      expect(keys.map((key) => key.text), ['á', 'ã', 'à', 'â', 'ä', 'å', 'æ']);
    });

    test('getDefs', () {
      final defs = parser.getDefs();

      expect(defs.length, 5);
      expect(defs.first.name.local, 'key');
      expect(defs.first.getAttribute('maxWidth'), '40');
    });

    test('getDefsItems', () {
      final def = parser.getDefItem('button');

      expect(def.name.local, 'button');
      expect(def.getAttribute('mr'), '3');
    });

    test('getDefItemAttribute', () {
      final attr = parser.getDefItemAttribute('button', 'mr');

      expect(attr, '3');
    });
  });

  group('VirtualKeyboardXMLParser 2', () {
    setUp(() {
      xmlContent = File('lib/src/keyboard_minimal.xml').readAsStringSync();
      parser = VirtualKeyboardXMLParser(xmlContent);
    });
  });

  group('VirtualKeyboardElementFactory', () {
    setUp(() {
      Get.reset();
      Get.put<BaseKeyElementFactory>(
        TestKeyElementFactory(
          doubleTapThershold: 0,
          holdTimeThreshold: 1,
          keyRep: 0,
          keyRepeatDelay: 2,
          toggle: false,
        ),
      );

      Get.put<BaseKeyActionFactory>(TestKeyActionFactory());
    });

    test('buildKeyElementWithKeyCode', () {
      final factory = VirtualKeyboardElementFactory();
      var key = factory.buildKeyElementWithKeyCode('a');

      expect(key.doubleTapThershold, 0);
      expect(key.holdTimeThreshold, 1);
      expect(key.keyRep, 0);
      expect(key.keyRepeatDelay, 2);
      expect(key.toggle, false);
      expect(key.action, isA<TestKeyAction>());
    });
  });
}
