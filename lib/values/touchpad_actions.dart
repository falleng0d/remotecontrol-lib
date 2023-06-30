import '../actions/action_base.dart';

/// TouchAction
/// - onPanUpdate: Send mose move events to the server via a [DragUpdateDetails] object.
class TouchpadActions {
  final BaseAction? touchpadMove;
  final BaseAction? tap;
  final BaseAction? doubleTapAndHold;
  final BaseAction? releaseDoubleTapAndHold;

  const TouchpadActions({
    this.touchpadMove,
    this.tap,
    this.doubleTapAndHold,
    this.releaseDoubleTapAndHold,
  });
}
