import 'package:win32/win32.dart' show VIRTUAL_KEY;

import '../exceptions.dart';

int stringToVk(String key) {
  throw UnimplementedError();
}

String vkToString(int vk) {
  throw UnimplementedError();
}


const List<int> _vkModifiers = [
  VIRTUAL_KEY.VK_SHIFT,
  VIRTUAL_KEY.VK_LSHIFT,
  VIRTUAL_KEY.VK_RSHIFT,
  VIRTUAL_KEY.VK_CONTROL,
  VIRTUAL_KEY.VK_LCONTROL,
  VIRTUAL_KEY.VK_RCONTROL,
  VIRTUAL_KEY.VK_MENU,
  VIRTUAL_KEY.VK_LMENU,
  VIRTUAL_KEY.VK_RMENU,
  VIRTUAL_KEY.VK_LWIN,
  VIRTUAL_KEY.VK_RWIN,
];

bool isModifierVk(int vk) => _vkModifiers.contains(vk);

List<int> getVkModifiers() => _vkModifiers;
