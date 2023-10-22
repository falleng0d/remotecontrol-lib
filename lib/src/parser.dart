import 'dart:io';

import 'package:xml/xml.dart';

import '../logger/logger.dart';

XmlNode recursiveDeepCopyNode(XmlNode node) {
  // node has no children
  if (node.children.isEmpty) {
    return node.copy();
  }

  final copy = node.copy();
  final children = node.children.map((child) => recursiveDeepCopyNode(child)).toList();
  copy.children.clear();
  copy.children.addAll(children);
  return copy;
}

void replaceNode(XmlNode original, List<XmlNode> newNodes) {
  final parent = original.parent;
  if (parent == null) {
    logger.error('Cannot replace node without parent');
    throw Exception('Cannot replace node without parent');
  }

  final index = parent.children.indexOf(original);
  if (index == -1) {
    logger.error('Cannot replace node without parent');
    throw Exception('Cannot replace node without parent');
  }

  parent.children.removeAt(index);
  parent.children.insertAll(index, newNodes);
}

class VirtualKeyboardXMLParser {
  final XmlDocument _document;

  /// /keyboard
  XmlElement get _root => _document.rootElement;

  VirtualKeyboardXMLParser(String xmlContent)
      : _document = XmlDocument.parse(xmlContent) {
    renderPresetInstances();
  }

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

  /// /keyboard/presets
  XmlElement getPresetsRoot() => _root.findElements('presets').first;

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

  void renderPresetInstances() {
    final presetsRoot = getPresetsRoot();
    final keysRoot = getKeyboardRoot();

    final presets = presetsRoot.findElements('preset');
    final presetInstances = keysRoot.findAllElements('preset');

    final Map<String, List<XmlNode>> presetsMap = {};

    if (presets.isEmpty && presetInstances.isNotEmpty) {
      logger.error('Preset called but no presets defined');
      throw Exception('Preset called but no presets defined');
    }

    for (final preset in presetsRoot.childElements) {
      final presetName = preset.getAttribute('name');
      if (presetName == null || presetName.isEmpty) {
        logger.warning('Preset must have a name');
        continue;
      }

      if (presetsMap.containsKey(presetName)) {
        logger.warning('Preset $presetName already exists');
        continue;
      }

      presetsMap[presetName] = preset.children.toList();
    }

    for (final instance in presetInstances) {
      final presetName = instance.getAttribute('name');
      if (presetName == null || presetName.isEmpty) {
        logger.warning('Preset instance must have a name');
        continue;
      }

      if (!presetsMap.containsKey(presetName)) {
        logger.warning('Preset for instance $presetName does not exist');
        continue;
      }

      final presetNodes = presetsMap[presetName]!;
      // deep copy
      final presetNodesCopy =
          presetNodes.map((node) => recursiveDeepCopyNode(node)).toList();
      replaceNode(instance, presetNodesCopy);
    }
  }
}
