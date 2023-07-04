/*
import 'dart:io';

import 'package:flutter/widgets.dart' show BuildContext, Container, Widget;
import 'package:get/get.dart';
import 'package:remotecontrol_lib/extension/geometry.dart';
import 'package:remotecontrol_lib/extension/xml_element.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

import '../factory/base/actions_factory_base.dart';
import '../factory/base/element_factory_base.dart';
import '../factory/keyboard_element_factory.dart';
import '../keyboard.dart';
import '../virtualkeys.dart';
import 'parser.dart';

class TestKeyElement extends BaseKeyElement {
  @override
  BaseAction<BaseKeyActionContext> action;
  @override
  BaseAction<BaseKeyActionContext>? doubleTapAction;

  @override
  double doubleTapThershold;
  @override
  BaseAction<BaseKeyActionContext>? holdAction;
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
  BaseKeyElement build(
    BaseAction<BaseKeyActionContext> action, {
    String? label,
    BaseAction<BaseKeyActionContext>? doubleTapAction,
    BaseAction<BaseKeyActionContext>? holdAction,
  }) {
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
  Future<bool> doAction(BaseActionContext ctx) async {
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
      expect(defs.first.attributes.length, 6);

      final attr1 = defs.first.attributes[0];
      expect(attr1.name.local, 'maxWidth');
      expect(attr1.value, '40');
    });

    test('getDefsItems', () {
      final def = parser.getDefItem('button');
      if (def == null) {
        fail('def is null');
      }

      expect(def.name.local, 'button');
      expect(def.getAttribute('mr'), '3');
    });

    test('getDefItemAttribute', () {
      final attr = parser.getDefItemAttribute('button', 'mr');

      expect(attr, '3');
    });

    test('Geometry withAttributes', () {
      // <key maxWidth="40" maxHeight="30" ml="3" mr="3" mt="2" mb="2" />
      final def = parser.getDefItem('key');
      if (def == null) {
        fail('def is null');
      }

      expect(def.getAttribute('maxWidth'), '40');
      expect(def.getAttribute('maxHeight'), '30');
      expect(def.getAttribute('ml'), '3');
      expect(def.getAttribute('mr'), '3');
      expect(def.getAttribute('mt'), '2');
      expect(def.getAttribute('mb'), '2');

      final geometry = Geometry().withAttributes(def);

      expect(geometry.maxWidth, 40);
      expect(geometry.maxHeight, 30);
      expect(geometry.margin?.left, 3);
      expect(geometry.margin?.right, 3);
      expect(geometry.margin?.top, 2);
      expect(geometry.margin?.bottom, 2);
    });
  });

  group('VirtualKeyboardXmlElementHelpers', () {
    // Tests for VirtualKeyboardXmlElementHelpers
    // Reference:
    // List<String> get _layoutTypes => ['row', 'column', 'flex', 'horizontal-spacer', 'vertical-spacer'];
    // List<String> get _elementTypes => ['key', 'button', 'text', 'touchpad'];
    // Iterable<XmlElement> get rows => findElements('row');
    // Iterable<XmlElement> get columns => findElements('column');
    // Iterable<XmlElement> get flexs => findElements('flex');
    // Iterable<XmlElement> get horizontalSpacers => findElements('horizontal-spacer');
    // Iterable<XmlElement> get verticalSpacers => findElements('vertical-spacer');
    // Iterable<XmlElement> get keys => findElements('key');
    // Iterable<XmlElement> get buttons => findElements('button');
    // Iterable<XmlElement> get texts => findElements('text');
    // Iterable<XmlElement> get touchpads => findElements('touchpad');
    // Iterable<XmlElement> get allNodes;
    // Iterable<XmlElement> get layoutNodes => findElements(_layoutTypes.join('|'));
    // Iterable<XmlElement> get keyNodes => findElements(_elementTypes.join('|'));

    late XmlElement root;

    setUp(() {
      xmlContent = File('lib/src/keyboard.xml').readAsStringSync();
      parser = VirtualKeyboardXMLParser(xmlContent);
      root = parser.getKeyboardRoot();
    });

    test('getKeyboardRoot', () {
      expect(root.tag, 'root');
    });

    test('column', () {
      expect(root.columns.length, 1);
    });

    test('rows', () {
      final column = root.columns.first;
      final rows = column.rows;

      expect(rows.length, 4);
    });

    test('layoutNodes', () {
      final column = root.columns.first;

      expect(column.layoutNodes.length, 4);
    });

    test('allNodes', () {
      final column = root.columns.first;
      final rows = column.rows;
      final row3 = rows.elementAt(2);

      final allNodes = row3.allNodes;
      expect(allNodes.length, 13);
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
      final factory = KeyboardElementFactory();
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
*/
