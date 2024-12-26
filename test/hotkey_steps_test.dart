import 'package:flutter_test/flutter_test.dart';
import 'package:remotecontrol_lib/values/hotkey_steps.dart';
import 'package:remotecontrol_lib/virtualkeys.dart';

void main() {
  group('HotkeyAction', () {
    test('Steps from "{Ctrl Down}c{Ctrl Up}"', () {
      final steps = stepsFromString("{Ctrl Down}c{Ctrl Up}", stringToKey);
      expect(steps.length, 4);
      expect(steps[0].keyCode, stringToKey("Ctrl"));
      expect(steps[0].actionType, KeyActionType.DOWN);
      expect(steps[1].keyCode, stringToKey("c"));
      expect(steps[1].actionType, KeyActionType.DOWN);
      expect(steps[2].keyCode, stringToKey("c"));
      expect(steps[2].actionType, KeyActionType.UP);
      expect(steps[3].keyCode, stringToKey("Ctrl"));
      expect(steps[3].actionType, KeyActionType.UP);
    });

    test('Steps from "{Ctrl Down}cv{Ctrl Up}"', () {
      final steps = stepsFromString("{Ctrl Down}cv{Ctrl Up}", stringToKey);
      expect(steps.length, 6);
    });

    test('Steps from "abcd"', () {
      final steps = stepsFromString("abcd", stringToKey);
      expect(steps.length, 8);
    });

    test('Steps from "{Ctrl Down}c{Ctrl Up:1000}"', () {
      final steps = stepsFromString("{Ctrl Down}c{Ctrl Up:1000}", stringToKey);
      expect(steps.length, 4);
      expect(steps[3].wait, 1000);
    });
  });
}
