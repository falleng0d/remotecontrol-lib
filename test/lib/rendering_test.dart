import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:remotecontrol_lib/logger.dart';
import 'package:remotecontrol_lib/src/rendering.dart';

class MockWidget {
  RCAction action;
  KeyboardWidget controller;

  MockWidget(this.action, this.controller);

  void ontap() {
    var ctx = ActionContext(controller.controller);
    action.doAction(ctx);
  }
}

class MockAction implements RCAction {
  @override bool doAction(ActionContext ctx) {
    print('MockAction');
    return true;
  }
}

void main() {
  /*test('Assert that all scheduled actions are executed', () {
    var rootLayout =
    FlexLayout(FlexibleGeometry(), Direction.Row, 'root', 0, 0);
    var controller = BaseInputClientController();
    var kbdController = KeyboardWidget(rootLayout, controller,
        ActionQueue(controller));

    var widget = MockWidget(MockAction(), kbdController);
    widget.ontap();
  });*/
}
