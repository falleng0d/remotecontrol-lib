import '../action_contexts.dart';
import '../keyboard.dart';

abstract class BaseElementProps {
  final String? label;
  final Geometry? geometry;

  bool get isFilled => label != null && geometry != null;

  const BaseElementProps({this.label, this.geometry});
}

class KeyElementProps extends BaseElementProps {
  final double? keyRep;
  final double? keyRepeatDelay;
  final bool? toggle;

  final double? holdTimeThreshold;
  final double? doubleTapThershold;

  final BaseAction<BaseKeyActionContext>? doubleTapAction;
  final BaseAction<BaseKeyActionContext>? holdAction;

  @override
  bool get isFilled {
    return super.isFilled &&
        keyRep != null &&
        keyRepeatDelay != null &&
        toggle != null &&
        holdTimeThreshold != null &&
        doubleTapThershold != null;
  }

  const KeyElementProps({
    String? label,
    Geometry? geometry,
    this.keyRep,
    this.keyRepeatDelay,
    this.toggle,
    this.holdTimeThreshold,
    this.doubleTapThershold,
    this.doubleTapAction,
    this.holdAction,
  }) : super(label: label, geometry: geometry);
}

class MouseElementProps extends BaseElementProps {
  const MouseElementProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);
}

class TextElementProps extends BaseElementProps {
  const TextElementProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);
}

class TouchpadElementProps extends BaseElementProps {
  final bool? scrollbar;
  final bool? mouseButtons;
  final bool? tapToClick;
  final bool? doubleTapAndHold;

  @override
  bool get isFilled {
    return super.isFilled &&
        scrollbar != null &&
        mouseButtons != null &&
        tapToClick != null &&
        doubleTapAndHold != null;
  }

  const TouchpadElementProps({
    String? label,
    Geometry? geometry,
    this.scrollbar,
    this.mouseButtons,
    this.tapToClick,
    this.doubleTapAndHold,
  }) : super(label: label, geometry: geometry);
}

class FlexLayoutProps extends BaseElementProps {
  final Direction? direction;
  final double? columnGap;
  final double? rowGap;
  final bool? expandChildren;

  @override
  bool get isFilled {
    return super.isFilled &&
        direction != null &&
        columnGap != null &&
        rowGap != null &&
        expandChildren != null;
  }

  const FlexLayoutProps({
    String? label,
    Geometry? geometry,
    this.direction,
    this.columnGap,
    this.rowGap,
    this.expandChildren,
  }) : super(label: label, geometry: geometry);
}

class RowLayoutProps extends BaseElementProps {
  final double? columnGap;
  final bool? expandChildren;

  @override
  bool get isFilled {
    return super.isFilled && columnGap != null && expandChildren != null;
  }

  const RowLayoutProps({
    String? label,
    Geometry? geometry,
    this.columnGap,
    this.expandChildren,
  }) : super(label: label, geometry: geometry);
}

class ColumnLayoutProps extends BaseElementProps {
  final double? rowGap;
  final bool? expandChildren;

  @override
  bool get isFilled {
    return super.isFilled && rowGap != null && expandChildren != null;
  }

  const ColumnLayoutProps({
    String? label,
    Geometry? geometry,
    this.rowGap,
    this.expandChildren,
  }) : super(label: label, geometry: geometry);
}

class HorizontalSpacerProps extends BaseElementProps {
  const HorizontalSpacerProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);
}

class VerticalSpacerProps extends BaseElementProps {
  const VerticalSpacerProps({String? label, Geometry? geometry})
      : super(label: label, geometry: geometry);
}
