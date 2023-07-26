import 'package:get/get.dart';

mixin Visible {
  bool _visible = true;

  /// Whether this element can be displayed or not.
  ///
  /// Even if [display] is set to `true`, if the parent element is not visible,
  /// this element will not be visible as well.
  ///
  /// This is set by the parent element.
  bool get visible => _visible;
  set visible(bool value) {
    if (_visible == value) return;

    final oldIsVisible = isVisible;
    _visible = value;

    if (isVisible != oldIsVisible) {
      if (value) {
        onShow();
      } else {
        onHide();
      }
    }
  }

  bool get isVisible => _visible;

  void onHide();
  void onShow();
}

mixin Displayable on Visible {
  final _display = true.obs;

  /// Whether this element is set to be displayed or not.
  /// This is in control of the element. Usually changed in reaction to a switch
  bool get display => _display.value;
  set display(bool value) {
    if (_display.value == value) return;

    final oldIsVisible = isVisible;
    _display.value = value;

    if (isVisible != oldIsVisible) {
      if (value) {
        onShow();
      } else {
        onHide();
      }
    }
  }

  @override
  bool get isVisible => _display.value && _visible;
  bool get isHidden => !_display.value || !_visible;
}
