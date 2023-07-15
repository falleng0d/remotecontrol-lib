//enum ColorGroup {
//   Key('key'),
//   Button('button'),
//   Text('text'),
//   Touchpad('touchpad');
//
//   const ColorGroup(this.token);
//
//   factory ColorGroup.from(String token) {
//     switch (token) {
//       case 'key':
//         return ColorGroup.Key;
//       case 'button':
//         return ColorGroup.Button;
//       case 'text':
//         return ColorGroup.Text;
//       case 'touchpad':
//         return ColorGroup.Touchpad;
//       default:
//         throw ArgumentError('Invalid ColorGroup token: $token');
//     }
//   }
//
//   final String token;
//
//   @override
//   String toString() {
//     return token;
//   }
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:remotecontrol_lib/values/color.dart';

void main() {
  group('ColorGroup Enum Tests', () {
    test('Can create a ColorGroup from the group name', () {
      final colorGroup = ColorGroup.from('key');
      expect(colorGroup, ColorGroup.Key);
    });

    test('Can get the name of the group', () {
      final colorGroup = ColorGroup.Key.toString();
      expect(colorGroup, 'key');
      expect("${ColorGroup.Key}", 'key');
    });

    test('Throws an error when creating a ColorGroup from an invalid name', () {
      expect(() => ColorGroup.from('invalid'), throwsArgumentError);
    });
  });
}
