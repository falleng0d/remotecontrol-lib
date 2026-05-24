// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'layout_parser.dart';

void main() {
  late KeyboardLayout layout;

  group('KeyboardLayoutXMLParser', () {
    setUp(() {
      layout = KeyboardLayout(enIntlKeyboardLayoutXML);
    });

    test('parses keyboard layout XML correctly', () {
      expect(layout.rightAltIsAltGr, 'true');
      expect(layout.shiftCancelsCapsLock, 'false');
      expect(layout.changesDirectionality, 'false');
      expect(layout.keys.isNotEmpty, true);
    });

    test('getKeyByVk returns correct key', () {
      final key = layout.getKeyByVk('VK_ESCAPE');
      expect(key.vk, 'VK_ESCAPE');
      expect(key.sc, '01');
      expect(key.name, 'ESC');
    });

    test('getKeyBySc returns correct key', () {
      final key = layout.getKeyBySc('01');
      expect(key.vk, 'VK_ESCAPE');
      expect(key.sc, '01');
      expect(key.name, 'ESC');
    });

    test('getKeyTextByVk returns correct text', () {
      final text = layout.getKeyTextByVk('VK_1');
      expect(text, '1');
    });

    test('getKeyTextBySc returns correct text', () {
      final text = layout.getKeyTextBySc('02');
      expect(text, '1');
    });

    test('getKeyTextByVk returns correct shifted text', () {
      final text = layout.getKeyTextByVk('VK_V');
      final shiftedText = layout.getKeyByVk('VK_V').shiftedText;

      expect(text, 'v');
      expect(shiftedText, 'V');
    });

    test('getKeyTextBySc returns correct shifted text', () {
      final shiftedText = layout.getKeyBySc('02').shiftedText;
      expect(shiftedText, '!');
    });

    test('getKeyByVk returns correct shifted text for VK_2', () {
      final shiftedText = layout.getKeyByVk('VK_2').shiftedText;
      expect(shiftedText, '@');
    });

    test('getKeyBySc returns correct shifted text for SC_03', () {
      final shiftedText = layout.getKeyBySc('03').shiftedText;
      expect(shiftedText, '@');
    });
  });
}
