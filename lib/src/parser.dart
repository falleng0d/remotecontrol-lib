import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:xml/xml.dart';

class Menu {
  final String id;
  final List<Key> keys;

  Menu(this.id, this.keys);
}

class VirtualKeyboardXMLParser {
  final XmlDocument _document;

  XmlElement get _root => _document.rootElement;

  VirtualKeyboardXMLParser(String xmlContent) : _document = XmlDocument.parse(xmlContent);

  factory VirtualKeyboardXMLParser.fromFile(String fileName) {
    return VirtualKeyboardXMLParser(_readFileContent(fileName));
  }

  // Helper method to read the file content
  static String _readFileContent(String fileName) {
    return File(fileName).readAsStringSync();
  }

  String? getKeyboardName() {
    return _root.getAttribute('name');
  }

  Iterable<XmlElement> getMenus() {
    return _root.findElements('menus').first.findElements('menu');
  }

  Iterable<XmlElement> getKeysForMenu(String menuId) {
    return _document
        .findAllElements('menu')
        .firstWhere((menu) => menu.getAttribute('id') == menuId)
        .findElements('key');
  }

  Iterable<XmlElement> getRootColumns() {
    return _document.findAllElements('column');
  }

  Iterable<XmlElement> getRowsForColumn(XmlElement column) {
    return column.findElements('row');
  }

  Iterable<XmlElement> getKeysForRow(XmlElement row) {
    return row.findElements('key');
  }

  Iterable<XmlElement> getTouchpadsForRow(XmlElement row) {
    return row.findElements('touchpad');
  }

  Iterable<XmlElement> getHorizontalSpacersForRow(XmlElement row) {
    return row.findElements('horizontal-spacer');
  }
}
