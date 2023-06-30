import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' show EdgeInsets, Key;
import 'package:get/get.dart';
import 'package:xml/xml.dart';

import '../action_contexts.dart';
import '../input/virtualkeys.dart';
import '../keyboard.dart';

class Menu {
  final String id;
  final List<Key> keys;

  Menu(this.id, this.keys);
}

mixin SizeableFactory {
  late Geometry _geometry;

  Geometry get geometry => _geometry.copy();
  set geometry(Geometry geometry) => _geometry = fillGeometryEmptyWithDefaults(geometry);

  EdgeInsets get margin => _geometry.margin!;
  set margin(EdgeInsets margin) => _geometry = _geometry.copyWith(margin: margin);

  EdgeInsets get padding => _geometry.padding!;
  set padding(EdgeInsets padding) => _geometry = _geometry.copyWith(padding: padding);

  double get width => _geometry.width!;
  set width(double width) => _geometry = _geometry.copyWith(width: width);

  double get height => _geometry.height!;
  set height(double height) => _geometry = _geometry.copyWith(height: height);

  double get minWidth => _geometry.minWidth!;
  set minWidth(double minWidth) => _geometry = _geometry.copyWith(minWidth: minWidth);

  double get maxWidth => _geometry.maxWidth!;
  set maxWidth(double maxWidth) => _geometry = _geometry.copyWith(maxWidth: maxWidth);

  double get minHeight => _geometry.minHeight!;
  set minHeight(double minHeight) => _geometry = _geometry.copyWith(minHeight: minHeight);

  double get maxHeight => _geometry.maxHeight!;
  set maxHeight(double maxHeight) => _geometry = _geometry.copyWith(maxHeight: maxHeight);

  bool get expand => _geometry.expand!;
  set expand(bool expand) => _geometry = _geometry.copyWith(expand: expand);

  int get flex => _geometry.flex!;
  set flex(int flex) => _geometry = _geometry.copyWith(flex: flex);

  Geometry fillGeometryEmptyWithDefaults(Geometry geometry) {
    return geometry.copyWith(
      minWidth: geometry.minWidth ?? 10,
      maxWidth: geometry.maxWidth ?? double.infinity,
      minHeight: geometry.minHeight ?? 10,
      maxHeight: geometry.maxHeight ?? double.infinity,
      expand: geometry.expand ?? false,
      flex: geometry.flex ?? 1,
      padding: geometry.padding ?? EdgeInsets.zero,
      margin: geometry.margin ?? EdgeInsets.zero,
    );
  }
}

/* region Value Objects */
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
/* endregion Value Objects */

/* region Props Loaders */
abstract class XmlPropsLoader<T> {
  T load(XmlElement node, {T? defaults});
  T merge(T into, {required XmlElement node});
}

class GeometryPropsLoader extends XmlPropsLoader<Geometry> {
  @override
  Geometry load(XmlElement node, {Geometry? defaults}) {
    return defaults != null
        ? defaults.withAttributes(node)
        : Geometry().withAttributes(node);
  }

  @override
  Geometry merge(Geometry into, {required XmlElement node}) {
    return into.withAttributes(node);
  }
}

class KeyElementPropsLoader extends XmlPropsLoader<KeyElementProps> {
  @override
  KeyElementProps load(XmlElement node, {KeyElementProps? defaults}) {
    return KeyElementProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsLoader().load(node, defaults: defaults?.geometry),
      keyRep: node.getAttributeValue('key-rep', defaults?.keyRep),
      keyRepeatDelay:
          node.getAttributeValue('key-repeat-delay', defaults?.keyRepeatDelay),
      toggle: node.getAttributeValue('toggle', defaults?.toggle),
      holdTimeThreshold:
          node.getAttributeValue('hold-time-threshold', defaults?.holdTimeThreshold),
      doubleTapThershold:
          node.getAttributeValue('double-tap-threshold', defaults?.doubleTapThershold),
      // doubleTapAction: node.getAttributeValue('double-tap-action', defaults?.doubleTapAction),
      // holdAction: node.getAttributeValue('hold-action', defaults?.holdAction),
    );
  }

  @override
  KeyElementProps merge(KeyElementProps into, {required XmlElement node}) {
    return KeyElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsLoader().merge(into.geometry!, node: node)
          : GeometryPropsLoader().load(node),
      keyRep: node.getAttributeValue('key-rep', into.keyRep),
      keyRepeatDelay: node.getAttributeValue('key-repeat-delay', into.keyRepeatDelay),
      toggle: node.getAttributeValue('toggle', into.toggle),
      holdTimeThreshold:
          node.getAttributeValue('hold-time-threshold', into.holdTimeThreshold),
      doubleTapThershold:
          node.getAttributeValue('double-tap-threshold', into.doubleTapThershold),
      // doubleTapAction: node.getAttributeValue('double-tap-action', into.doubleTapAction),
      // holdAction: node.getAttributeValue('hold-action', into.holdAction),
    );
  }
}

class MouseElementPropsLoader extends XmlPropsLoader<MouseElementProps> {
  @override
  MouseElementProps load(XmlElement node, {MouseElementProps? defaults}) {
    return MouseElementProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsLoader().load(node, defaults: defaults?.geometry),
    );
  }

  @override
  MouseElementProps merge(MouseElementProps into, {required XmlElement node}) {
    return MouseElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsLoader().merge(into.geometry!, node: node)
          : GeometryPropsLoader().load(node),
    );
  }
}

class TextElementPropsLoader extends XmlPropsLoader<TextElementProps> {
  @override
  TextElementProps load(XmlElement node, {TextElementProps? defaults}) {
    return TextElementProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsLoader().load(node, defaults: defaults?.geometry),
    );
  }

  @override
  TextElementProps merge(TextElementProps into, {required XmlElement node}) {
    return TextElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsLoader().merge(into.geometry!, node: node)
          : GeometryPropsLoader().load(node),
    );
  }
}

class TouchpadElementPropsLoader extends XmlPropsLoader<TouchpadElementProps> {
  @override
  TouchpadElementProps load(XmlElement node, {TouchpadElementProps? defaults}) {
    return TouchpadElementProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsLoader().load(node, defaults: defaults?.geometry),
      scrollbar: node.getAttributeValue('scrollbar', defaults?.scrollbar),
      mouseButtons: node.getAttributeValue('mouse-buttons', defaults?.mouseButtons),
      tapToClick: node.getAttributeValue('tap-to-click', defaults?.tapToClick),
      doubleTapAndHold:
          node.getAttributeValue('double-tap-and-hold', defaults?.doubleTapAndHold),
    );
  }

  @override
  TouchpadElementProps merge(TouchpadElementProps into, {required XmlElement node}) {
    return TouchpadElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsLoader().merge(into.geometry!, node: node)
          : GeometryPropsLoader().load(node),
      scrollbar: node.getAttributeValue('scrollbar', into.scrollbar),
      mouseButtons: node.getAttributeValue('mouse-buttons', into.mouseButtons),
      tapToClick: node.getAttributeValue('tap-to-click', into.tapToClick),
      doubleTapAndHold:
          node.getAttributeValue('double-tap-and-hold', into.doubleTapAndHold),
    );
  }
}

class FlexLayoutPropsLoader extends XmlPropsLoader<FlexLayoutProps> {
  @override
  FlexLayoutProps load(XmlElement node, {FlexLayoutProps? defaults}) {
    return FlexLayoutProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsLoader().load(node, defaults: defaults?.geometry),
      direction: node.getAttributeValue('direction', defaults?.direction),
      columnGap: node.getAttributeValue('column-gap', defaults?.columnGap),
      rowGap: node.getAttributeValue('row-gap', defaults?.rowGap),
      expandChildren: node.getAttributeValue('expand-children', defaults?.expandChildren),
    );
  }

  @override
  FlexLayoutProps merge(FlexLayoutProps into, {required XmlElement node}) {
    return FlexLayoutProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsLoader().merge(into.geometry!, node: node)
          : GeometryPropsLoader().load(node),
      direction: node.getAttributeValue('direction', into.direction),
      columnGap: node.getAttributeValue('column-gap', into.columnGap),
      rowGap: node.getAttributeValue('row-gap', into.rowGap),
      expandChildren: node.getAttributeValue('expand-children', into.expandChildren),
    );
  }
}

class RowLayoutPropsLoader extends XmlPropsLoader<RowLayoutProps> {
  @override
  RowLayoutProps load(XmlElement node, {RowLayoutProps? defaults}) {
    return RowLayoutProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsLoader().load(node, defaults: defaults?.geometry),
      columnGap: node.getAttributeValue('column-gap', defaults?.columnGap),
      expandChildren: node.getAttributeValue('expand-children', defaults?.expandChildren),
    );
  }

  @override
  RowLayoutProps merge(RowLayoutProps into, {required XmlElement node}) {
    return RowLayoutProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsLoader().merge(into.geometry!, node: node)
          : GeometryPropsLoader().load(node),
      columnGap: node.getAttributeValue('column-gap', into.columnGap),
      expandChildren: node.getAttributeValue('expand-children', into.expandChildren),
    );
  }
}

class ColumnLayoutPropsLoader extends XmlPropsLoader<ColumnLayoutProps> {
  @override
  ColumnLayoutProps load(XmlElement node, {ColumnLayoutProps? defaults}) {
    return ColumnLayoutProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsLoader().load(node, defaults: defaults?.geometry),
      rowGap: node.getAttributeValue('row-gap', defaults?.rowGap),
      expandChildren: node.getAttributeValue('expand-children', defaults?.expandChildren),
    );
  }

  @override
  ColumnLayoutProps merge(ColumnLayoutProps into, {required XmlElement node}) {
    return ColumnLayoutProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsLoader().merge(into.geometry!, node: node)
          : GeometryPropsLoader().load(node),
      rowGap: node.getAttributeValue('row-gap', into.rowGap),
      expandChildren: node.getAttributeValue('expand-children', into.expandChildren),
    );
  }
}

class HorizontalSpacerPropsLoader extends XmlPropsLoader<HorizontalSpacerProps> {
  @override
  HorizontalSpacerProps load(XmlElement node, {HorizontalSpacerProps? defaults}) {
    return HorizontalSpacerProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsLoader().load(node, defaults: defaults?.geometry),
    );
  }

  @override
  HorizontalSpacerProps merge(HorizontalSpacerProps into, {required XmlElement node}) {
    return HorizontalSpacerProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsLoader().merge(into.geometry!, node: node)
          : GeometryPropsLoader().load(node),
    );
  }
}

class VerticalSpacerPropsLoader extends XmlPropsLoader<VerticalSpacerProps> {
  @override
  VerticalSpacerProps load(XmlElement node, {VerticalSpacerProps? defaults}) {
    return VerticalSpacerProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsLoader().load(node, defaults: defaults?.geometry),
    );
  }

  @override
  VerticalSpacerProps merge(VerticalSpacerProps into, {required XmlElement node}) {
    return VerticalSpacerProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsLoader().merge(into.geometry!, node: node)
          : GeometryPropsLoader().load(node),
    );
  }
}
/* endregion Props Loaders */

/* region Abstract Element Factories */
class BaseElementFactory<T extends BaseElementProps, E extends XmlPropsLoader<T>>
    with SizeableFactory {
  covariant T props;
  covariant E propsLoader;

  BaseElementFactory(T props, E propsLoader)
      : props = props,
        propsLoader = propsLoader {
    assert(props.isFilled);
  }
}

abstract class BaseKeyElementFactory
    extends BaseElementFactory<KeyElementProps, KeyElementPropsLoader> {
  BaseKeyElementFactory(KeyElementProps props, propsLoader) : super(props, propsLoader);

  BaseKeyElement build(
    covariant BaseAction<BaseKeyActionContext> action, {
    String? label,
    KeyElementProps? overrides,
  });
}

abstract class BaseMouseButtonElementFactory
    extends BaseElementFactory<MouseElementProps, MouseElementPropsLoader> {
  BaseMouseButtonElementFactory(props, propsLoader) : super(props, propsLoader);

  BaseButtonElement build(
    covariant BaseAction<BaseButtonActionContext> action, {
    String? label,
    MouseElementProps? overrides,
  });
}

abstract class BaseTextElementFactory
    extends BaseElementFactory<TextElementProps, TextElementPropsLoader> {
  BaseTextElementFactory(props, propsLoader) : super(props, propsLoader);

  BaseTextElement build(String label, {TextElementProps? overrides});
}

abstract class BaseTouchpadElementFactory
    extends BaseElementFactory<TouchpadElementProps, TouchpadElementPropsLoader> {
  TouchpadActions get actions;

  BaseTouchpadElementFactory(props, propsLoader) : super(props, propsLoader);

  BaseTouchpadElement build({String? label, TouchpadElementProps? overrides});
}
/* endregion Abstract Element Factories */

/* region Abstract Layout Element Factories */
abstract class BaseLayoutFactory<T extends BaseElementProps, E extends XmlPropsLoader<T>>
    extends BaseElementFactory<T, E> {
  BaseLayoutFactory(props, propsLoader) : super(props, propsLoader);
}

abstract class BaseFlexLayoutFactory
    extends BaseLayoutFactory<FlexLayoutProps, FlexLayoutPropsLoader> {
  BaseFlexLayoutFactory(props, propsLoader) : super(props, propsLoader);

  FlexLayout build(
      {String? label, FlexLayoutProps? overrides, List<BaseElement>? children});
}

abstract class BaseRowLayoutFactory
    extends BaseLayoutFactory<RowLayoutProps, RowLayoutPropsLoader> {
  BaseRowLayoutFactory(props, propsLoader) : super(props, propsLoader);

  RowLayout build(
      {String? label, RowLayoutProps? overrides, List<BaseElement>? children});
}

abstract class BaseColumnLayoutFactory
    extends BaseLayoutFactory<ColumnLayoutProps, ColumnLayoutPropsLoader> {
  BaseColumnLayoutFactory(props, propsLoader) : super(props, propsLoader);

  ColumnLayout build(
      {String? label, ColumnLayoutProps? overrides, List<BaseElement>? children});
}

abstract class BaseHorizontalSpacerFactory
    extends BaseLayoutFactory<HorizontalSpacerProps, HorizontalSpacerPropsLoader> {
  BaseHorizontalSpacerFactory(props, propsLoader) : super(props, propsLoader);

  HorizontalSpacer build({String? label, HorizontalSpacerProps? overrides});
}

abstract class BaseVerticalSpacerFactory
    extends BaseLayoutFactory<VerticalSpacerProps, VerticalSpacerPropsLoader> {
  BaseVerticalSpacerFactory(props, propsLoader) : super(props, propsLoader);

  VerticalSpacer build({String? label, VerticalSpacerProps? overrides});
}
/* endregion Abstract Layout Element Factories */

/* region Abstract Action Factories */
abstract class BaseKeyActionFactory {
  BaseKeyAction build(String keyCode);
}

abstract class BaseButtonActionFactory {
  BaseMouseButtonAction build(MouseButtonType button);
}
/* endregion Abstract Action Factories */

class VirtualKeyboardElementFactory {
  /* region Fields */
  BaseKeyElementFactory? __baseKeyElementFactory;
  BaseMouseButtonElementFactory? __baseMouseButtonElementFactory;
  BaseTextElementFactory? __baseTextElementFactory;
  BaseTouchpadElementFactory? __baseTouchpadElementFactory;

  BaseFlexLayoutFactory? __baseFlexLayoutFactory;
  BaseRowLayoutFactory? __baseRowLayoutFactory;
  BaseColumnLayoutFactory? __baseColumnLayoutFactory;
  BaseHorizontalSpacerFactory? __baseHorizontalSpacerFactory;
  BaseVerticalSpacerFactory? __baseVerticalSpacerFactory;

  BaseKeyActionFactory? __baseKeyActionFactory;
  BaseButtonActionFactory? __baseMouseButtonActionFactory;
  /* endregion Fields */

  /* region Getters */
  BaseKeyElementFactory get _baseKeyElementFactory {
    if (__baseKeyElementFactory == null) {
      throw Exception('BaseKeyElementFactory is not registered');
    }

    return __baseKeyElementFactory!;
  }

  BaseMouseButtonElementFactory get _baseMouseButtonElementFactory {
    if (__baseMouseButtonElementFactory == null) {
      throw Exception('BaseMouseButtonElementFactory is not registered');
    }

    return __baseMouseButtonElementFactory!;
  }

  BaseTextElementFactory get _baseTextElementFactory {
    if (__baseTextElementFactory == null) {
      throw Exception('BaseTextElementFactory is not registered');
    }

    return __baseTextElementFactory!;
  }

  BaseTouchpadElementFactory get _baseTouchpadElementFactory {
    if (__baseTouchpadElementFactory == null) {
      throw Exception('BaseTouchpadElementFactory is not registered');
    }

    return __baseTouchpadElementFactory!;
  }

  BaseFlexLayoutFactory get _baseFlexLayoutFactory {
    if (__baseFlexLayoutFactory == null) {
      throw Exception('BaseFlexLayoutFactory is not registered');
    }

    return __baseFlexLayoutFactory!;
  }

  BaseRowLayoutFactory get _baseRowLayoutFactory {
    if (__baseRowLayoutFactory == null) {
      throw Exception('BaseRowLayoutFactory is not registered');
    }

    return __baseRowLayoutFactory!;
  }

  BaseColumnLayoutFactory get _baseColumnLayoutFactory {
    if (__baseColumnLayoutFactory == null) {
      throw Exception('BaseColumnLayoutFactory is not registered');
    }

    return __baseColumnLayoutFactory!;
  }

  BaseHorizontalSpacerFactory get _baseHorizontalSpacerFactory {
    if (__baseHorizontalSpacerFactory == null) {
      throw Exception('BaseHorizontalSpacerFactory is not registered');
    }

    return __baseHorizontalSpacerFactory!;
  }

  BaseVerticalSpacerFactory get _baseVerticalSpacerFactory {
    if (__baseVerticalSpacerFactory == null) {
      throw Exception('BaseVerticalSpacerFactory is not registered');
    }

    return __baseVerticalSpacerFactory!;
  }

  BaseKeyActionFactory get _baseKeyActionFactory {
    if (__baseKeyActionFactory == null) {
      throw Exception('BaseKeyActionFactory is not registered');
    }

    return __baseKeyActionFactory!;
  }

  BaseButtonActionFactory get _baseMouseButtonActionFactory {
    if (__baseMouseButtonActionFactory == null) {
      throw Exception('BaseMouseButtonActionFactory is not registered');
    }

    return __baseMouseButtonActionFactory!;
  }
  /* endregion Getters */

  VirtualKeyboardElementFactory() {
    resolveDependencies();
  }

  void resolveDependencies() {
    if (Get.isRegistered<BaseKeyElementFactory>()) {
      __baseKeyElementFactory = Get.find<BaseKeyElementFactory>();
    }
    if (Get.isRegistered<BaseMouseButtonElementFactory>()) {
      __baseMouseButtonElementFactory = Get.find<BaseMouseButtonElementFactory>();
    }
    if (Get.isRegistered<BaseTextElementFactory>()) {
      __baseTextElementFactory = Get.find<BaseTextElementFactory>();
    }
    if (Get.isRegistered<BaseTouchpadElementFactory>()) {
      __baseTouchpadElementFactory = Get.find<BaseTouchpadElementFactory>();
    }

    if (Get.isRegistered<BaseFlexLayoutFactory>()) {
      __baseFlexLayoutFactory = Get.find<BaseFlexLayoutFactory>();
    }
    if (Get.isRegistered<BaseRowLayoutFactory>()) {
      __baseRowLayoutFactory = Get.find<BaseRowLayoutFactory>();
    }
    if (Get.isRegistered<BaseColumnLayoutFactory>()) {
      __baseColumnLayoutFactory = Get.find<BaseColumnLayoutFactory>();
    }
    if (Get.isRegistered<BaseHorizontalSpacerFactory>()) {
      __baseHorizontalSpacerFactory = Get.find<BaseHorizontalSpacerFactory>();
    }
    if (Get.isRegistered<BaseVerticalSpacerFactory>()) {
      __baseVerticalSpacerFactory = Get.find<BaseVerticalSpacerFactory>();
    }

    if (Get.isRegistered<BaseKeyActionFactory>()) {
      __baseKeyActionFactory = Get.find<BaseKeyActionFactory>();
    }
    if (Get.isRegistered<BaseButtonActionFactory>()) {
      __baseMouseButtonActionFactory = Get.find<BaseButtonActionFactory>();
    }
  }

  /* region Action Builders */
  BaseKeyAction buildKeyAction(String keyCode) {
    return _baseKeyActionFactory.build(keyCode);
  }

  BaseMouseButtonAction buildMouseButtonAction(MouseButtonType button) {
    return _baseMouseButtonActionFactory.build(button);
  }
  /* endregion Action Builders */

  /* region Element Builders */
  BaseKeyElement buildKeyElement(
    XmlElement node,
    covariant BaseKeyAction action, {
    String label = 'key',
  }) {
    return _baseKeyElementFactory.build(
      action,
      label: label,
      overrides: _baseKeyElementFactory.propsLoader.merge(
        _baseKeyElementFactory.props,
        node: node,
      ),
    );
  }

  BaseKeyElement buildKeyElementWithKeyCode(
    XmlElement node,
    String keyCode, {
    String label = 'key',
  }) {
    final action = buildKeyAction(keyCode);
    return buildKeyElement(node, action, label: label);
  }

  BaseButtonElement buildMouseButtonElement(
    XmlElement node,
    covariant BaseAction<BaseButtonActionContext> action, {
    String label = 'mouseButton',
  }) {
    return _baseMouseButtonElementFactory.build(action,
        label: label,
        overrides: _baseMouseButtonElementFactory.propsLoader.merge(
          _baseMouseButtonElementFactory.props,
          node: node,
        ));
  }

  BaseButtonElement buildMouseButtonElementWithButtonType(
    XmlElement node,
    MouseButtonType button, {
    String label = 'mouseButton',
  }) {
    final action = buildMouseButtonAction(button);
    return buildMouseButtonElement(node, action, label: label);
  }

  BaseTextElement buildTextElement(XmlElement node, String label) {
    return _baseTextElementFactory.build(
      label,
      overrides: _baseTextElementFactory.propsLoader.merge(
        _baseTextElementFactory.props,
        node: node,
      ),
    );
  }

  BaseTouchpadElement buildTouchpadElement(XmlElement node, {String label = 'touchpad'}) {
    throw UnimplementedError('buildTouchpadElement is not implemented');
  }
  /* endregion Element Builders */

  /* region Layout Builders */
  FlexLayout buildFlexLayout(
    XmlElement node, {
    String label = 'flexLayout',
    List<BaseElement> children = const [],
  }) {
    return _baseFlexLayoutFactory.build(
      label: label,
      children: children,
      overrides: _baseFlexLayoutFactory.propsLoader
          .merge(_baseFlexLayoutFactory.props, node: node),
    );
  }

  RowLayout buildRowLayout(
    XmlElement node, {
    String label = 'rowLayout',
    List<BaseElement> children = const [],
  }) {
    return _baseRowLayoutFactory.build(
      label: label,
      children: children,
      overrides: _baseRowLayoutFactory.propsLoader.merge(
        _baseRowLayoutFactory.props,
        node: node,
      ),
    );
  }

  ColumnLayout buildColumnLayout(
    XmlElement node, {
    String label = 'columnLayout',
    List<BaseElement> children = const [],
  }) {
    return _baseColumnLayoutFactory.build(
      label: label,
      children: children,
      overrides: _baseColumnLayoutFactory.propsLoader.merge(
        _baseColumnLayoutFactory.props,
        node: node,
      ),
    );
  }

  HorizontalSpacer buildHorizontalSpacer(
    XmlElement node, {
    String label = 'horizontalSpacer',
  }) {
    return _baseHorizontalSpacerFactory.build(
      label: label,
      overrides: _baseHorizontalSpacerFactory.propsLoader.merge(
        _baseHorizontalSpacerFactory.props,
        node: node,
      ),
    );
  }

  VerticalSpacer buildVerticalSpacer(
    XmlElement node, {
    String label = 'verticalSpacer',
  }) {
    return _baseVerticalSpacerFactory.build(
      label: label,
      overrides: _baseVerticalSpacerFactory.propsLoader.merge(
        _baseVerticalSpacerFactory.props,
        node: node,
      ),
    );
  }

  /* endregion Layout Builders */
}

class VirtualKeyboardXMLParser {
  final XmlDocument _document;

  /// /keyboard
  XmlElement get _root => _document.rootElement;

  VirtualKeyboardXMLParser(String xmlContent) : _document = XmlDocument.parse(xmlContent);

  factory VirtualKeyboardXMLParser.fromFile(String fileName) {
    return VirtualKeyboardXMLParser(_readFileContent(fileName));
  }

  factory VirtualKeyboardXMLParser.fromString(String xml) {
    return VirtualKeyboardXMLParser(xml);
  }

  // Helper method to read the file content
  static String _readFileContent(String fileName) => File(fileName).readAsStringSync();

  /// /keyboard/@name
  String? getKeyboardName() => _root.getAttribute('name');

  /* region Menus */

  /// /keyboard/menus
  XmlElement getMenusRoot() => _root.findElements('menus').first;

  /// /keyboard/menus/[*]
  Iterable<XmlElement> getMenus() => getMenusRoot().findElements('menu');

  /// /keyboard/menus/menu/[id]
  XmlElement getMenu(String id) =>
      getMenus().firstWhere((menu) => menu.getAttribute('id') == id);

  /// /keyboard/menus/menu/[id]/[*]
  Iterable<XmlElement> getMenuItems(String id) => getMenu(id).childElements;

  /* endregion Menus */

  /* region Defs */

  /// /keyboard/defs
  XmlElement getDefsRoot() => _root.findElements('defs').first;

  /// /keyboard/defs/[*]
  Iterable<XmlElement> getDefs() => getDefsRoot().childElements;

  /// /keyboard/defs/def/[tag]
  XmlElement? getDefItem(String nodeName) {
    try {
      return getDefs().firstWhere((def) => def.name.local == nodeName);
    } on StateError catch (_) {
      return null;
    }
  }

  /// /keyboard/defs/def/[tag]/@[attr]
  String? getDefItemAttribute(String nodeName, String attrName) =>
      getDefItem(nodeName)?.getAttribute(attrName);

  /* endregion Defs */

  /* region Keyboard Items */

  /// /keyboard/root
  XmlElement getKeyboardRoot() => _root.findElements('root').first;

  /* endregion Keyboard Items */
}

typedef double_opt = double?;
typedef bool_opt = bool?;
typedef int_opt = int?;
typedef String_opt = String?;

extension VirtualKeyboardXmlElementHelpers on XmlElement {
  String get tag => name.local;

  List<String> get _layoutTypes =>
      ['row', 'column', 'flex', 'horizontal-spacer', 'vertical-spacer'];
  List<String> get _elementTypes => ['key', 'button', 'text', 'touchpad'];

  Iterable<XmlElement> get rows => findElements('row');
  Iterable<XmlElement> get columns => findElements('column');
  Iterable<XmlElement> get flexs => findElements('flex');
  Iterable<XmlElement> get horizontalSpacers => findElements('horizontal-spacer');
  Iterable<XmlElement> get verticalSpacers => findElements('vertical-spacer');

  Iterable<XmlElement> get keys => findElements('key');
  Iterable<XmlElement> get buttons => findElements('button');
  Iterable<XmlElement> get texts => findElements('text');
  Iterable<XmlElement> get touchpads => findElements('touchpad');

  Iterable<XmlElement> get layoutNodes {
    return _layoutTypes.map((type) => findElements(type)).expand((element) => element);
  }

  Iterable<XmlElement> get keyNodes {
    return _elementTypes.map((type) => findElements(type)).expand((element) => element);
  }

  Iterable<XmlElement> get allNodes {
    return layoutNodes.followedBy(keyNodes);
  }

  T getAttributeValue<T>(String name, T defaultValue) {
    final attribute = getAttribute(name);
    if (attribute == null) return defaultValue;

    if (T == double || T == double_opt) {
      return double.parse(attribute) as T;
    } else if (T == bool || T == bool_opt) {
      return (attribute.toLowerCase() == 'true') as T;
    } else if (T == int || T == int_opt) {
      return int.parse(attribute) as T;
    } else if (T == String || T == String_opt) {
      return attribute as T;
    }
    return defaultValue;
  }
}

/// [KeyboardNodeRenderer] uses a [VirtualKeyboardElementFactory] to render a
/// [XmlElement] into a [BaseElement] displayable widget.
///
/// It starts from the provided node and renders all its children recursively,
/// resulting into a tree of [BaseElement] widgets.
///
/// Only [BaseLayout] elements can have children, so the rendering process
/// will throw an exception if a child is found in a non-layout node.
extension KeyboardNodeRenderer on XmlElement {
  BaseElement render(VirtualKeyboardElementFactory factory) {
    switch (tag) {
      case 'root':
        return allNodes.first.render(factory);
      case 'row':
        return _renderRow(factory);
      case 'column':
        return _renderColumn(factory);
      case 'flex':
        return _renderFlex(factory);
      case 'horizontal-spacer':
        return _renderHorizontalSpacer(factory);
      case 'vertical-spacer':
        return _renderVerticalSpacer(factory);
      case 'key':
        return _renderKey(factory);
      case 'button':
        return _renderButton(factory);
      case 'text':
        return _renderText(factory);
      case 'touchpad':
        // TODO: return _renderTouchpad(factory);
        throw Exception('Touchpad not implemented yet');
      default:
        throw Exception('Unknown node type: $tag');
    }
  }

  FlexLayout _renderFlex(VirtualKeyboardElementFactory factory) {
    return factory.buildFlexLayout(
      this,
      children: childElements.map((node) => node.render(factory)).toList(),
    );
  }

  RowLayout _renderRow(VirtualKeyboardElementFactory factory) {
    return factory.buildRowLayout(
      this,
      children: childElements.map((node) => node.render(factory)).toList(),
    );
  }

  ColumnLayout _renderColumn(VirtualKeyboardElementFactory factory) {
    return factory.buildColumnLayout(
      this,
      children: childElements.map((node) => node.render(factory)).toList(),
    );
  }

  HorizontalSpacer _renderHorizontalSpacer(VirtualKeyboardElementFactory factory) {
    return factory.buildHorizontalSpacer(this);
  }

  VerticalSpacer _renderVerticalSpacer(VirtualKeyboardElementFactory factory) {
    return factory.buildVerticalSpacer(this);
  }

  BaseKeyElement _renderKey(VirtualKeyboardElementFactory factory) {
    final keyCode = text;
    if (keyCode.isEmpty) {
      throw Exception('Key node must have a text with a key code');
    }

    return factory.buildKeyElementWithKeyCode(this, keyCode, label: keyCode);
  }

  BaseElement _renderButton(VirtualKeyboardElementFactory factory) {
    final buttonName = text;
    if (buttonName.isEmpty) {
      throw Exception('Button node must have a text with a button name');
    }

    // One of enum MouseButtonType { LEFT, RIGHT, MIDDLE, X1, X2 }
    switch (buttonName.toLowerCase()) {
      case 'left':
        return factory.buildMouseButtonElementWithButtonType(this, MouseButtonType.LEFT,
            label: 'LEFT');
      case 'right':
        return factory.buildMouseButtonElementWithButtonType(this, MouseButtonType.RIGHT,
            label: 'RIGHT');
      case 'middle':
        return factory.buildMouseButtonElementWithButtonType(this, MouseButtonType.MIDDLE,
            label: 'MIDDLE');
      case 'x1':
        return factory.buildMouseButtonElementWithButtonType(this, MouseButtonType.X1,
            label: 'X1');
      case 'x2':
        return factory.buildMouseButtonElementWithButtonType(this, MouseButtonType.X2,
            label: 'X2');
      default:
        throw Exception('Unknown button type: $buttonName');
    }
  }

  BaseTextElement _renderText(VirtualKeyboardElementFactory factory) {
    final text = this.text;
    if (text.isEmpty) {
      throw Exception('Text node must have a text');
    }

    return factory.buildTextElement(this, text);
  }
}

/// [GeometryXMLNodeDeserializer] adds utility method to [Geometry]
/// that allows load attributes from a [XmlElement] and create a new
/// [Geometry] instance with those attributes.
extension GeometryXMLNodeDeserializer on Geometry {
  Geometry withAttributes(XmlElement node) {
    return Geometry(
      width: node.getAttributeValue('width', width),
      height: node.getAttributeValue('height', height),
      minWidth: node.getAttributeValue('minWidth', minWidth),
      maxWidth: node.getAttributeValue('maxWidth', maxWidth),
      minHeight: node.getAttributeValue('minHeight', minHeight),
      maxHeight: node.getAttributeValue('maxHeight', maxHeight),
      expand: node.getAttributeValue('expand', expand),
      flex: node.getAttributeValue('flex', flex),
      padding: EdgeInsets.fromLTRB(
        node.getAttributeValue('pl', padding?.left) ?? 0,
        node.getAttributeValue('pt', padding?.top) ?? 0,
        node.getAttributeValue('pr', padding?.right) ?? 0,
        node.getAttributeValue('pb', padding?.bottom) ?? 0,
      ),
      margin: EdgeInsets.fromLTRB(
        node.getAttributeValue('ml', margin?.left) ?? 0,
        node.getAttributeValue('mt', margin?.top) ?? 0,
        node.getAttributeValue('mr', margin?.right) ?? 0,
        node.getAttributeValue('mb', margin?.bottom) ?? 0,
      ),
    );
  }
}
