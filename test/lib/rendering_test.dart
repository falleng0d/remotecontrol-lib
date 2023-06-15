import 'package:remotecontrol_lib/src/rendering.dart';

class MockWidget {
  RCAction action;
  VirtualKeyboard controller;

  MockWidget(this.action, this.controller);

  void ontap(ActionContext ctx) {
    action.doAction(ctx);
  }
}

class MockAction implements RCAction {
  @override
  Future<void> doAction(ActionContext ctx) async {
    print('MockAction');
  }
}

void main() {
  /*test('Assert that all scheduled actions are executed', () {
    var rootLayout =
    FlexLayout(Geometry(), Direction.Row, 'root', 0, 0);
    var controller = BaseInputClientController();
    var kbdController = KeyboardWidget(rootLayout, controller,
        ActionQueue(controller));

    var widget = MockWidget(MockAction(), kbdController);
    widget.ontap();
  });*/
}
