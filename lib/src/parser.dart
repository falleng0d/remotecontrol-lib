import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' show Key;
import 'package:xml/xml.dart';

class Menu {
  final String id;
  final List<Key> keys;

  Menu(this.id, this.keys);
}

class VirtualKeyboardXMLParser {
  final XmlDocument _document;

  /// /keyboard
  XmlElement get _root => _document.rootElement;

  VirtualKeyboardXMLParser(String xmlContent) : _document = XmlDocument.parse(xmlContent);

  factory VirtualKeyboardXMLParser.fromFile(String fileName) {
    return VirtualKeyboardXMLParser(_readFileContent(fileName));
  }

  factory VirtualKeyboardXMLParser.fromString(String xml) {
    return VirtualKeyboardXMLParser(xml);
  }

  // Helper method to read the file content
  static String _readFileContent(String fileName) => File(fileName).readAsStringSync();

  /// /keyboard/@name
  String? getKeyboardName() => _root.getAttribute('name');

  /* region Menus */

  /// /keyboard/menus
  XmlElement getMenusRoot() => _root.findElements('menus').first;

  /// /keyboard/menus/[*]
  Iterable<XmlElement> getMenus() => getMenusRoot().findElements('menu');

  /// /keyboard/menus/menu/[id]
  XmlElement getMenu(String id) =>
      getMenus().firstWhere((menu) => menu.getAttribute('id') == id);

  /// /keyboard/menus/menu/[id]/[*]
  Iterable<XmlElement> getMenuItems(String id) => getMenu(id).childElements;

  /* endregion Menus */

  /* region Defs */

  /// /keyboard/defs
  XmlElement getDefsRoot() => _root.findElements('defs').first;

  /// /keyboard/defs/[*]
  Iterable<XmlElement> getDefs() => getDefsRoot().childElements;

  /// /keyboard/defs/def/[tag]
  XmlElement? getDefItem(String nodeName) {
    try {
      return getDefs().firstWhere((def) => def.name.local == nodeName);
    } on StateError catch (_) {
      return null;
    }
  }

  /// /keyboard/defs/def/[tag]/@[attr]
  String? getDefItemAttribute(String nodeName, String attrName) =>
      getDefItem(nodeName)?.getAttribute(attrName);

  /* endregion Defs */

  /* region Keyboard Items */

  /// /keyboard/root
  XmlElement getKeyboardRoot() => _root.findElements('root').first;

  /* endregion Keyboard Items */
}
