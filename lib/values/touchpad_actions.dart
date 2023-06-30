import '../actions/action_base.dart';

/// TouchAction
/// - onPanUpdate: Send mose move events to the server via a [DragUpdateDetails] object.
class TouchpadActions {
  final BaseMouseMoveAction? touchpadMove;
  final BaseMouseButtonAction? tap;
  final BaseMouseButtonAction? rightTap;
  final BaseMouseButtonAction? doubleTapAndHold;
  final BaseMouseButtonAction? releaseDoubleTapAndHold;

  const TouchpadActions({
    this.touchpadMove,
    this.tap,
    this.rightTap,
    this.doubleTapAndHold,
    this.releaseDoubleTapAndHold,
  });
}
