import 'package:flutter/widgets.dart';

import '../keyboard.dart';
import '../logger/logger.dart';

class VirtualKeyboard {
  final BaseElement child;
  final Logger? logger;

  VirtualKeyboard({required this.child, this.logger});

  Widget build(BuildContext context) {
    return child.build(context);
  }
}
