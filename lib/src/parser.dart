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

  Geometry fillGeometryEmptyWithDefaults(Geometry geometry) {
    return geometry.copyWith(
      minWidth: geometry.minWidth ?? 10,
      maxWidth: geometry.maxWidth ?? double.infinity,
      minHeight: geometry.minHeight ?? 10,
      maxHeight: geometry.maxHeight ?? double.infinity,
      expand: geometry.expand ?? false,
      padding: geometry.padding ?? EdgeInsets.zero,
      margin: geometry.margin ?? EdgeInsets.zero,
    );
  }
}

/* region Abstract Element Factories */
abstract class BaseElementFactory with SizeableFactory {
  BaseElementFactory([Geometry? geometry]) {
    this.geometry = geometry ?? const Geometry();
  }
}

abstract class BaseKeyElementFactory extends BaseElementFactory {
  double get keyRep;
  double get keyRepeatDelay;
  bool get toggle;

  double get holdTimeThreshold;
  double get doubleTapThershold;

  BaseKeyElementFactory([Geometry? geometry]) : super(geometry);

  BaseKeyElement build(
    covariant BaseAction<KeyActionContext> action, {
    String? label,
    covariant BaseAction<KeyActionContext>? doubleTapAction,
    covariant BaseAction<KeyActionContext>? holdAction,
  });
}

abstract class BaseMouseButtonElementFactory extends BaseElementFactory {
  BaseMouseButtonElementFactory([Geometry? geometry]) : super(geometry);

  BaseButtonElement build(covariant BaseAction<ButtonActionContext> action,
      {String? label});
}

abstract class BaseTextElementFactory extends BaseElementFactory {
  BaseTextElementFactory([Geometry? geometry]) : super(geometry);

  BaseTextElement build(String label);
}

abstract class BaseTouchpadElementFactory extends BaseElementFactory {
  bool get scrollbar;
  bool get mouseButtons;
  bool get tapToClick;
  bool get doubleTapAndHold;

  TouchpadActions get actions;

  BaseTouchpadElementFactory([Geometry? geometry]) : super(geometry);

  BaseTouchpadElement build({String? label});
}
/* endregion Abstract Element Factories */

/* region Abstract Layout Element Factories */
abstract class BaseLayoutFactory extends BaseElementFactory {
  BaseLayoutFactory([Geometry? geometry]) : super(geometry);
}

abstract class BaseFlexLayoutFactory extends BaseLayoutFactory {
  Direction get direction;
  double get columnGap;
  double get rowGap;
  bool get expandChildren;

  BaseFlexLayoutFactory([Geometry? geometry]) : super(geometry);

  FlexLayout build({
    String? label,
    Direction? direction,
    double? columnGap,
    double? rowGap,
    bool? expandChildren,
    List<BaseElement>? children,
  });
}

abstract class BaseRowLayoutFactory extends BaseLayoutFactory {
  double get columnGap;
  bool get expandChildren;

  BaseRowLayoutFactory([Geometry? geometry]) : super(geometry);

  RowLayout build({
    String? label,
    double? columnGap,
    bool? expandChildren,
    List<BaseElement>? children,
  });
}

abstract class BaseColumnLayoutFactory extends BaseLayoutFactory {
  double get rowGap;
  bool get expandChildren;

  BaseColumnLayoutFactory([Geometry? geometry]) : super(geometry);

  ColumnLayout build({
    String? label,
    double? rowGap,
    bool? expandChildren,
    List<BaseElement>? children,
  });
}

abstract class BaseHorizontalSpacerFactory extends BaseLayoutFactory {
  BaseHorizontalSpacerFactory([Geometry? geometry]) : super(geometry);

  HorizontalSpacer build({String? label});
}

abstract class BaseVerticalSpacerFactory extends BaseLayoutFactory {
  BaseVerticalSpacerFactory([Geometry? geometry]) : super(geometry);

  VerticalSpacer build({String? label});
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
  BaseKeyElement buildKeyElement(BaseKeyAction action,
      {String label = 'key',
      BaseAction<KeyActionContext>? doubleTapAction,
      BaseAction<KeyActionContext>? holdAction}) {
    return _baseKeyElementFactory.build(action,
        label: label, doubleTapAction: doubleTapAction, holdAction: holdAction);
  }

  BaseKeyElement buildKeyElementWithKeyCode(String keyCode,
      {String label = 'key',
      BaseAction<KeyActionContext>? doubleTapAction,
      BaseAction<KeyActionContext>? holdAction}) {
    final action = buildKeyAction(keyCode);
    return buildKeyElement(action,
        label: label, doubleTapAction: doubleTapAction, holdAction: holdAction);
  }

  BaseButtonElement buildMouseButtonElement(BaseAction<ButtonActionContext> action,
      {String label = 'mouseButton'}) {
    return _baseMouseButtonElementFactory.build(action, label: label);
  }

  BaseButtonElement buildMouseButtonElementWithButtonType(MouseButtonType button,
      {String label = 'mouseButton'}) {
    final action = buildMouseButtonAction(button);
    return buildMouseButtonElement(action, label: label);
  }

  BaseTextElement buildTextElement(String label) {
    return _baseTextElementFactory.build(label);
  }

  BaseTouchpadElement buildTouchpadElement({String label = 'touchpad'}) {
    throw UnimplementedError('buildTouchpadElement is not implemented');
  }
  /* endregion Element Builders */

  /* region Layout Builders */
  FlexLayout buildFlexLayout({
    String label = 'flexLayout',
    List<BaseElement> children = const [],
    Direction? direction,
    double? columnGap,
    double? rowGap,
    bool? expandChildren,
  }) {
    return _baseFlexLayoutFactory.build(
      label: label,
      children: children,
      direction: direction,
      columnGap: columnGap,
      rowGap: rowGap,
      expandChildren: expandChildren,
    );
  }

  RowLayout buildRowLayout({
    String label = 'rowLayout',
    List<BaseElement> children = const [],
    double? columnGap,
    double? rowGap,
    bool? expandChildren,
  }) {
    return _baseRowLayoutFactory.build(
      label: label,
      children: children,
      columnGap: columnGap,
      expandChildren: expandChildren,
    );
  }

  ColumnLayout buildColumnLayout({
    String label = 'columnLayout',
    List<BaseElement> children = const [],
    double? columnGap,
    double? rowGap,
    bool? expandChildren,
  }) {
    return _baseColumnLayoutFactory.build(
      label: label,
      children: children,
      rowGap: rowGap,
      expandChildren: expandChildren,
    );
  }

  HorizontalSpacer buildHorizontalSpacer({String label = 'horizontalSpacer'}) {
    return _baseHorizontalSpacerFactory.build();
  }

  VerticalSpacer buildVerticalSpacer({String label = 'verticalSpacer'}) {
    return _baseVerticalSpacerFactory.build();
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
  XmlElement getKeyboardRoot() => _root;

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

  Iterable<XmlElement> get allNodes {
    return findElements(_layoutTypes.join('|') + '|' + _elementTypes.join('|'));
  }

  Iterable<XmlElement> get layoutNodes => findElements(_layoutTypes.join('|'));
  Iterable<XmlElement> get keyNodes => findElements(_elementTypes.join('|'));

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

  RowLayout _renderRow(VirtualKeyboardElementFactory factory) {
    final row = factory._baseRowLayoutFactory.build();
    for (final node in childElements) {
      row.addChild(node.render(factory));
    }
    return row;
  }

  ColumnLayout _renderColumn(VirtualKeyboardElementFactory factory) {
    final column = factory._baseColumnLayoutFactory.build();
    for (final node in childElements) {
      column.addChild(node.render(factory));
    }
    return column;
  }

  FlexLayout _renderFlex(VirtualKeyboardElementFactory factory) {
    final flex = factory._baseFlexLayoutFactory.build();
    for (final node in childElements) {
      flex.addChild(node.render(factory));
    }
    return flex;
  }

  HorizontalSpacer _renderHorizontalSpacer(VirtualKeyboardElementFactory factory) {
    return factory._baseHorizontalSpacerFactory.build();
  }

  VerticalSpacer _renderVerticalSpacer(VirtualKeyboardElementFactory factory) {
    return factory._baseVerticalSpacerFactory.build();
  }

  BaseKeyElement _renderKey(VirtualKeyboardElementFactory factory) {
    final keyCode = text;
    if (keyCode.isEmpty) {
      throw Exception('Key node must have a text with a key code');
    }

    // TODO: final doubleTapAction = getAttribute('double-tap-action');
    // TODO: final holdAction = getAttribute('hold-action');

    return factory.buildKeyElementWithKeyCode(keyCode);
  }

  BaseElement _renderButton(VirtualKeyboardElementFactory factory) {
    final buttonName = text;

    // One of enum MouseButtonType { LEFT, RIGHT, MIDDLE, X1, X2 }
    switch (buttonName.toLowerCase()) {
      case 'left':
        return factory.buildMouseButtonElementWithButtonType(MouseButtonType.LEFT);
      case 'right':
        return factory.buildMouseButtonElementWithButtonType(MouseButtonType.RIGHT);
      case 'middle':
        return factory.buildMouseButtonElementWithButtonType(MouseButtonType.MIDDLE);
      case 'x1':
        return factory.buildMouseButtonElementWithButtonType(MouseButtonType.X1);
      case 'x2':
        return factory.buildMouseButtonElementWithButtonType(MouseButtonType.X2);
      default:
        throw Exception('Unknown button type: $buttonName');
    }
  }

  BaseTextElement _renderText(VirtualKeyboardElementFactory factory) {
    final text = this.text;
    if (text.isEmpty) {
      throw Exception('Text node must have a text');
    }

    return factory.buildTextElement(text);
  }
}

/// [GeometryXMLNodeDeserializer] adds utility method to [Geometry]
/// that allows load attributes from a [XmlElement] and create a new
/// [Geometry] instance with those attributes.
extension GeometryXMLNodeDeserializer on Geometry {
  Geometry withAttributes(XmlElement node) {
    return Geometry(
      minWidth: node.getAttributeValue('minWidth', minWidth),
      maxWidth: node.getAttributeValue('maxWidth', maxWidth),
      minHeight: node.getAttributeValue('minHeight', minHeight),
      maxHeight: node.getAttributeValue('maxHeight', maxHeight),
      expand: node.getAttributeValue('expand', expand),
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
