import 'dart:io';
import 'dart:ui';

import 'package:xml/xml.dart';

import '../logger/logger.dart';

XmlNode recursiveDeepCopyNode(XmlNode node) {
  // node has no children
  if (node.children.isEmpty) {
    return node.copy();
  }

  final copy = node.copy();
  copy.attributes.clear();
  for (var attr in node.attributes) {
    copy.attributes.add(attr.copy());
  }
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
  XmlElement getDefsRoot() {
    try {
      return _root.findElements('defs').first;
    } on StateError catch (e) {
      throw Exception('No defs found: $e');
    }
  }

  /// /keyboard/presets
  XmlElement? getPresetsRoot() {
    return _root.findElements('presets').firstOrNull;
  }

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

    if (presetsRoot == null) {
      return;
    }

    final Map<String, List<XmlNode>> presetsMap = {};

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

    if (presetsMap.isEmpty) {
      return;
    }

    var presetInstances = keysRoot.findAllElements('preset');

    while (presetInstances.isNotEmpty) {
      for (final instance in presetInstances) {
        final presetName = instance.getAttribute('name') ??
            (instance.innerText.isNotEmpty ? instance.innerText : null);

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

        final Map<String, String> presetVariables = getPresetVariables(instance);
        substituteVariables(presetNodesCopy, presetVariables);

        replaceNode(instance, presetNodesCopy);
      }

      presetInstances = keysRoot.findAllElements('preset');
    }
  }

  /// Get the variables defined in the preset instance
  /// A variable is any attribute except name
  Map<String, String> getPresetVariables(XmlElement instance) {
    final variables = <String, String>{};
    final attributes = instance.attributes;

    for (final attr in attributes) {
      if (attr.name.local == 'name') {
        continue;
      }

      variables[attr.name.local] = attr.value;
    }

    return variables;
  }

  /// Recursively traverse the tree starting from the given node and replace
  /// the variables by their values in the given map
  /// The subistitution is done in place on all attributes and text nodes
  /// with the following format: ${variableName}
  void substituteVariables(List<XmlNode> nodes, Map<String, String> variables) {
    final List<VoidCallback> deferred = [];
    // ignore: avoid_function_literals_in_foreach_calls
    processDeferred() => deferred.forEach((e) => e());

    for (var node in nodes) {
      if (node is XmlElement) {
        final attributes = node.attributes;
        for (final attr in attributes) {
          final value = attr.value;

          final maybeExactVariable = RegExp(r'^\${(\w+)}$').firstMatch(value)?.group(1);
          if (maybeExactVariable != null) {
            final variableName = maybeExactVariable;

            if (!variables.containsKey(variableName)) {
              logger.warning('Variable ${attr.name.local}="\$$variableName" not set when '
                  'rendering preset instance based on: $node');
              // Attribute has no substitution value, remove it so it can inherit
              // from the <defs/> node
              deferred.add(() => node.attributes.remove(attr));
              continue;
            }

            final variableValue = variables[variableName]!;
            if (variableValue == 'null') {
              deferred.add(() => node.attributes.remove(attr));
              continue;
            }

            attr.value = variables[variableName]!;
            continue;
          }

          if (value.contains('\${')) {
            final newValue = value.replaceAllMapped(
              RegExp(r'\${(\w+)}'),
              (match) {
                final variableName = match.group(1);
                if (variableName == null) {
                  return '';
                }

                if (!variables.containsKey(variableName)) {
                  logger.warning('Variable $variableName not set when '
                      'rendering preset instance based on: $node');
                  return '';
                }

                return variables[variableName]!;
              },
            );

            attr.value = newValue;
          }
        }
      } else if (node is XmlText) {
        final text = node.value;
        if (text.contains('\${')) {
          final newText = text.replaceAllMapped(
            RegExp(r'\${(\w+)}'),
            (match) {
              final variableName = match.group(1);
              if (variableName == null) {
                return '';
              }

              if (!variables.containsKey(variableName)) {
                logger.warning('Variable $variableName not set when '
                    'rendering preset instance based on: $node');
                return '';
              }

              return variables[variableName]!;
            },
          );

          node.value = newText;
        }
      }

      substituteVariables(node.children, variables);
    }

    processDeferred();
  }
}
