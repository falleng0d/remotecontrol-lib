import 'package:win32/win32.dart';
import 'key_action.dart';

Map<MouseButtonType, int> _mouseButtonToVK = {
  MouseButtonType.LEFT: VIRTUAL_KEY.VK_LBUTTON,
  MouseButtonType.RIGHT: VIRTUAL_KEY.VK_RBUTTON,
  MouseButtonType.MIDDLE: VIRTUAL_KEY.VK_MBUTTON,
  MouseButtonType.X1: VIRTUAL_KEY.VK_XBUTTON1,
  MouseButtonType.X2: VIRTUAL_KEY.VK_XBUTTON2,
};
Map<int, MouseButtonType> _vkToMouseButton =
_mouseButtonToVK.map((k, v) => MapEntry(v, k));

int mouseButtonToVK(MouseButtonType button) {
  if (!_mouseButtonToVK.containsKey(button)) {
    throw ArgumentError('Invalid mouse button type');
  }

  return _mouseButtonToVK[button]!;
}

MouseButtonType vkToMouseButton(int vk) {
  if (!_vkToMouseButton.containsKey(vk)) {
    throw ArgumentError('Invalid virtual key');
  }

  return _vkToMouseButton[vk]!;
}
