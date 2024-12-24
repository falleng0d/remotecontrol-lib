import 'package:win32/win32.dart';
import '../button.dart';

Map<Button, int> _mouseButtonToVK = {
  Button.LEFT: VIRTUAL_KEY.VK_LBUTTON,
  Button.RIGHT: VIRTUAL_KEY.VK_RBUTTON,
  Button.MIDDLE: VIRTUAL_KEY.VK_MBUTTON,
  Button.X1: VIRTUAL_KEY.VK_XBUTTON1,
  Button.X2: VIRTUAL_KEY.VK_XBUTTON2,
};
final Map<int, Button> _vkToMouseButton = _mouseButtonToVK.map((k, v) => MapEntry(v, k));

int mouseButtonToVK(Button button) {
  if (!_mouseButtonToVK.containsKey(button)) {
    throw ArgumentError('Invalid mouse button type');
  }

  return _mouseButtonToVK[button]!;
}

Button vkToMouseButton(int vk) {
  if (!_vkToMouseButton.containsKey(vk)) {
    throw ArgumentError('Invalid virtual key');
  }

  return _vkToMouseButton[vk]!;
}
