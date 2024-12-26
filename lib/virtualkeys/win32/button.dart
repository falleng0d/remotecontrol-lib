import 'package:win32/win32.dart' show MOUSE_EVENT_FLAGS;
import '../button.dart';

/// Windows has a different way of handling mouse buttons
/// each button has a specific key down and key up event
/// this class is used to map the mouse button to the key events
/// so that the correct key events can be sent to the system
/// to simulate the mouse button press
class ButtonFlags {
  final Button button;
  final int keyDown;
  final int keyUp;

  const ButtonFlags(this.button, this.keyDown, this.keyUp);

  static ButtonFlags fromMouseButton(Button button) {
    switch (button) {
      case Button.LEFT:
        return ButtonFlags(button, MOUSE_EVENT_FLAGS.MOUSEEVENTF_LEFTDOWN,
            MOUSE_EVENT_FLAGS.MOUSEEVENTF_LEFTUP);
      case Button.RIGHT:
        return ButtonFlags(button, MOUSE_EVENT_FLAGS.MOUSEEVENTF_RIGHTDOWN,
            MOUSE_EVENT_FLAGS.MOUSEEVENTF_RIGHTUP);
      case Button.MIDDLE:
        return ButtonFlags(button, MOUSE_EVENT_FLAGS.MOUSEEVENTF_MIDDLEDOWN,
            MOUSE_EVENT_FLAGS.MOUSEEVENTF_MIDDLEUP);
      case Button.X1:
        return ButtonFlags(button, MOUSE_EVENT_FLAGS.MOUSEEVENTF_XDOWN,
            MOUSE_EVENT_FLAGS.MOUSEEVENTF_XUP);
      case Button.X2:
        throw UnimplementedError('X2 button not implemented');
      case Button.X3:
        throw UnimplementedError('X3 button not implemented');
      case Button.X4:
        throw UnimplementedError('X4 button not implemented');
      case Button.X5:
        throw UnimplementedError('X5 button not implemented');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ButtonFlags &&
              runtimeType == other.runtimeType &&
              keyDown == other.keyDown &&
              keyUp == other.keyUp;

  @override
  int get hashCode => keyDown.hashCode ^ keyUp.hashCode;

  @override
  String toString() {
    return button.toString();
  }
}
