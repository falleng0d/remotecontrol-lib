import '../../keyboard.dart';
import '../../src/virtualkeys.dart';

abstract class BaseKeyActionFactory {
  BaseKeyAction build(String keyCode);
}

abstract class BaseButtonActionFactory {
  BaseMouseButtonAction build(MouseButtonType button);
}

abstract class BaseMouseMoveActionFactory {
  BaseMouseMoveAction build();
}
