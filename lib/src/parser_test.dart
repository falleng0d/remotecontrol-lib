import 'dart:io';

import 'package:flutter/widgets.dart' show BuildContext, Container, Widget;
import 'package:get/get.dart';
import 'package:test/test.dart';

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
  }) : super(geometry: geometry, label: label);

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
  BaseKeyElement build(String label, BaseAction action,
      {BaseAction? doubleTapAction, BaseAction? holdAction}) {
    return TestKeyElement(
      geometry: geometry,
      label: label,
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

void main() {
  late String xmlContent;
  late VirtualKeyboardXMLParser parser;

  setUp(() {
    xmlContent = File('lib/src/keyboard.xml').readAsStringSync();
    parser = VirtualKeyboardXMLParser(xmlContent);
  });

  group('VirtualKeyboardXMLParser', () {
    test('getKeyboardName', () {
      expect(parser.getKeyboardName(), 'Split Keyboard');
    });

    test('getMenus', () {
      final menus = parser.getMenus();
      expect(menus.length, 1);
      expect(menus.first.getAttribute('id'), 'menu1');
    });

    test('getKeysForMenu', () {
      final keys = parser.getKeysForMenu('menu1');
      expect(keys.length, 7);
      expect(keys.map((key) => key.text), ['á', 'ã', 'à', 'â', 'ä', 'å', 'æ']);
    });

    test('getRootColumns', () {
      final columns = parser.getRootColumns();
      expect(columns.length, 1);
    });

    test('getRowsForColumn', () {
      final rows = parser.getRowsForColumn(parser.getRootColumns().first);
      expect(rows.length, 4);
    });

    test('getKeysForRow', () {
      final rows = parser.getRowsForColumn(parser.getRootColumns().first);
      final keys = parser.getKeysForRow(rows.elementAt(1));
      expect(keys.length, 13);
    });

    test('getTouchpadsForRow', () {
      final rows = parser.getRowsForColumn(parser.getRootColumns().first);
      final touchpads = parser.getTouchpadsForRow(rows.first);
      expect(touchpads.length, 1);
    });

    test('getHorizontalSpacersForRow', () {
      final rows = parser.getRowsForColumn(parser.getRootColumns().first);
      final spacers = parser.getHorizontalSpacersForRow(rows.elementAt(2));
      expect(spacers.length, 1);
    });
  });

  group('VirtualKeyboardElementFactory', () {
    test('build', () {
      Get.put<BaseKeyElementFactory>(
        TestKeyElementFactory(
          doubleTapThershold: 0,
          holdTimeThreshold: 1,
          keyRep: 0,
          keyRepeatDelay: 2,
          toggle: false,
        ),
      );
      final factory = VirtualKeyboardElementFactory();
      var action = CallbackAction((_) async => true);
      var key = factory.buildKeyElement('test', action);
      expect(key.doubleTapThershold, 0);
      expect(key.holdTimeThreshold, 1);
      expect(key.keyRep, 0);
      expect(key.keyRepeatDelay, 2);
      expect(key.toggle, false);
      expect(key.action, action);
    });
  });
}
