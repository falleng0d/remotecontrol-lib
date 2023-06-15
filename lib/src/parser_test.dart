import 'dart:io';

import 'package:remotecontrol_lib/src/parser.dart';
import 'package:test/test.dart';

void main() {
  late String xmlContent;
  late VirtualKeyboardXMLParser parser;

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
}
