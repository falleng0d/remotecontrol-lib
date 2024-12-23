// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:remotecontrol_lib/extension/geometry.dart';
// import 'package:flutter/widgets.dart' show BuildContext, Container, Widget;
// import 'package:get/get.dart';
import 'package:remotecontrol_lib/extension/xml_element.dart';
import 'package:remotecontrol_lib/values/geometry.dart';
import 'package:xml/xml.dart';

import 'parser.dart';

void main() {
  late VirtualKeyboardXMLParser parser;

  // language=xml
  const String xmlContent = '''<?xml version="1.0" encoding="UTF-8" ?>
<keyboard name="Split Keyboard">
    <defs>
        <key width="36" minWidth="90" maxWidth="40" maxHeight="30" ml="3" mr="3" mt="2" mb="2" />
        <button maxWidth="40" maxHeight="30" ml="3" mr="3" mt="2" mb="2" />
        <horizontal-spacer expand="true" />
        <touchpad />
    </defs>
    <presets>
        <preset name="preset0">
          <key label="preset0-key">\${param0}-\${param1}</key>
        </preset>
        <preset name="preset1">
          <row label="preset1-instance">
              <key width="\${param}">q</key>
              <key label="\${param}-\${param2}">w</key>
              <key maxHeight="\${param}" width="\${param2}">e</key>
          </row>
          <preset name="preset0" param0="0" param1="\${param}" />
        </preset>
        <preset name="preset2">
          <key label="preset2-key" width="\${width}">P2</key>
        </preset>
    </presets>
    <root>
        <column label="root" align="end">
            <preset name="preset1" param="40" param2="50" />
            <preset name="preset2" width="null" />
            <column label="touchpad" expand="true">
                <touchpad scrollbar="true">
                    <button>LButton</button>
                    <button>RButton</button>
                </touchpad>
            </column>
            <row label="qwerty">
                <key>q</key>
                <horizontal-spacer />
                <key>w</key>
                <key width="2">Backspace</key>
            </row>
        </column>
    </root>
</keyboard>
''';

  group('VirtualKeyboardXMLParser presets', () {
    setUp(() {
      parser = VirtualKeyboardXMLParser(xmlContent);
    });

    test('presets are rendered successfully', () {
      parser.renderPresetInstances();

      final presetsRoot = parser.getPresetsRoot();
      expect(presetsRoot, isNotNull);

      // check that preset1-instance is rendered
      final keyboardRoot = parser.getKeyboardRoot();
      final preset1Instance = keyboardRoot.findAllElements('row').firstWhere(
            (element) => element.getAttribute('label') == 'preset1-instance',
          );
      expect(preset1Instance, isNotNull);
      expect(preset1Instance.getAttribute('label'), 'preset1-instance');

      // check that param is substituted
      final key1 = preset1Instance.findElements('key').first;
      expect(key1.getAttribute('width'), '40');

      final key2 = preset1Instance.findElements('key').elementAt(1);
      expect(key2.getAttribute('label'), '40-50');

      final key3 = preset1Instance.findElements('key').last;
      expect(key3.getAttribute('maxHeight'), '40');
      expect(key3.getAttribute('width'), '50');

      final preset0Key = keyboardRoot.findAllElements('key').firstWhere(
            (element) => element.getAttribute('label') == 'preset0-key',
          );
      expect(preset0Key, isNotNull);
      expect(preset0Key.innerText, '0-40');

      final preset2Key = keyboardRoot.findAllElements('key').firstWhere(
            (element) => element.getAttribute('label') == 'preset2-key',
          );
      expect(preset2Key, isNotNull);
      expect(preset2Key.getAttribute('width'), null);
    });
  });

  group('VirtualKeyboardXMLParser basic', () {
    setUp(() {
      parser = VirtualKeyboardXMLParser(xmlContent);
    });

    test('getKeyboardName', () {
      expect(parser.getKeyboardName(), 'Split Keyboard');
    });

    test('getDefs', () {
      final defs = parser.getDefs();

      expect(defs.first.name.local, 'key');

      final attr1 = defs.first.attributes[1];
      expect(attr1.name.local, 'minWidth');
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

      final geometry = const Geometry().withAttributes(def);

      expect(geometry.maxWidth, 40);
      expect(geometry.maxHeight, 30);
      expect(geometry.margin?.left, 3);
      expect(geometry.margin?.right, 3);
      expect(geometry.margin?.top, 2);
      expect(geometry.margin?.bottom, 2);
    });
  });

  group('VirtualKeyboardXmlElementHelpers', () {
    late XmlElement root;

    setUp(() {
      parser = VirtualKeyboardXMLParser(xmlContent);
      root = parser.getKeyboardRoot();
    });

    test('getKeyboardRoot', () {
      expect(root.tag, 'root');
    });
  });

  group('VirtualKeyboardXMLParser 2', () {
    setUp(() {
      parser = VirtualKeyboardXMLParser(xmlContent);
    });
  });
}
