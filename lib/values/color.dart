import 'package:flutter/material.dart';

enum ColorGroup {
  Key('key'),
  Button('button'),
  Text('text'),
  Touchpad('touchpad');

  const ColorGroup(this.token);

  factory ColorGroup.from(String token) {
    try {
      return ColorGroup.values.firstWhere((e) => e.token == token);
    } on StateError {
      throw ArgumentError('Invalid ColorGroup: $token');
    }
  }

  final String token;

  @override
  String toString() => token;
}

/// [KeyColor] is a pair of up, down and optional special state colors
class KeyColor {
  final Color up;
  final Color down;
  final Color? toggle;
  final Color? toggleLocked;

  static const KeyColor defaultColor = KeyColor(up: Colors.blue, down: Colors.blue);

  const KeyColor({required this.up, required this.down, this.toggle, this.toggleLocked});
}
