// Hotkeys are expressed as a sequence of steps
// Example:
// - {Ctrl Down}c{Ctrl Up} -> 4 steps (Ctrl down, c down, c up, Ctrl up)
// - {Ctrl Down}cv{Ctrl Up} -> 6 steps (Ctrl down, c down, c up, v down, v up, Ctrl up)
// - abcd -> 4 steps (a down, a up, b down, b up, c down, c up, d down, d up)
// - {Ctrl Down}c{Ctrl Up:1000} -> 4 steps (Ctrl down, c down, c up, Ctrl up after 1 second)

import 'package:flutter/widgets.dart';

import '../virtualkeys.dart';

@immutable
class HotkeyStep {
  final int keyCode;

  /// UP, DOWN, PRESS (UP then DOWN)
  final KeyActionType actionType;

  /// Wait before executing this step
  final int? wait;

  /// The speed of the key press (only applicable for actionType == PRESS)
  final int? speed;

  const HotkeyStep({
    required this.keyCode,
    required this.actionType,
    this.wait,
    this.speed,
  });
}

List<HotkeyStep> stepsFromString(String string) {
  final steps = <HotkeyStep>[];
  final regex = RegExp(r'\{(.+?)\}');
  string.splitMapJoin(
    regex,
    onMatch: (m) {
      final command = m.group(1)!;
      final parts = command.split(':');
      final subparts = parts[0].split(' ');
      final key = subparts[0];
      final actionName = subparts.length > 1 ? subparts[1] : 'PRESS';
      final KeyActionType action = keyActionTypeFromName(actionName);
      final wait = parts.length > 1 ? int.parse(parts[1]) : null;
      if (action == KeyActionType.PRESS) {
        steps.add(HotkeyStep(
          keyCode: stringToVk(key),
          actionType: KeyActionType.DOWN,
        ));
        steps.add(HotkeyStep(
          keyCode: stringToVk(key),
          actionType: KeyActionType.UP,
          wait: wait,
        ));
      } else {
        steps.add(HotkeyStep(
          keyCode: stringToVk(key),
          actionType: action,
          wait: wait,
        ));
      }
      return '';
    },
    onNonMatch: (n) {
      for (final char in n.split('')) {
        steps.add(HotkeyStep(keyCode: stringToVk(char), actionType: KeyActionType.DOWN));
        steps.add(HotkeyStep(keyCode: stringToVk(char), actionType: KeyActionType.UP));
      }
      return '';
    },
  );
  return steps;
}
