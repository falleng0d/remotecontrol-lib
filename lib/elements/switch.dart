import 'package:uuid/uuid.dart';

import 'element_base.dart';

class Switch {
  final String label;
  final String uuid;
  final String switchId;
  final bool initialState;
  bool _state = false;

  final List<BaseElement> _children;

  bool get state => initialState == true ? _state : !_state;

  List<BaseElement> get children => _children;

  Switch({
    required this.label,
    required this.switchId,
    required this.initialState,
    required List<BaseElement> children,
  })  : uuid = const Uuid().v4(),
        _state = false,
        _children = children;

  void setState(bool value) {
    if (_state == value) return;

    // final oldState = _state;
    _state = value;

    update();

    // print('[Switch] Switch ${uuid.substring(0, 4)} '
    //     'switchId: $switchId initialState: $initialState $oldState -> $_state '
    //     '(actual state: $state)');
  }

  void toggle() {
    // final oldState = _state;
    setState(!_state);

    //  print('[Switch] Switch '
    //      'switchId: $switchId initialState: $initialState $oldState -> $_state');
  }

  void update() {
    for (final child in _children) {
      child.display = state;
    }
  }

  void onShow() => update();

  void onHide() => update();
}
