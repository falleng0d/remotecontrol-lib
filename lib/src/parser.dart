import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' show EdgeInsets, Key;
import 'package:get/get.dart';
import 'package:xml/xml.dart';

import '../keyboard.dart';

class Menu {
  final String id;
  final List<Key> keys;

  Menu(this.id, this.keys);
}

/*
* Element types:
* - BaseTextElement
* - BaseKeyElement
* - BaseTouchpadElement
* - BaseMouseButtonElement
*
* Layot types:
* - ColumnLayout
* - RowLayout
* - VerticalSpacer
* - HorizontalSpacer
* - FlexLayout
* */

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

  BaseKeyElement build(String label, BaseAction action,
      {BaseAction? doubleTapAction, BaseAction? holdAction});
}

abstract class BaseMouseButtonElementFactory extends BaseElementFactory {
  BaseAction get action;

  BaseMouseButtonElementFactory(BaseAction action, [Geometry? geometry])
      : super(geometry);

  BaseMouseButtonElement build(String label);
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

  BaseTouchpadElement build(String label);
}
/* endregion */

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

  FlexLayout build(String label);
}

abstract class BaseRowLayoutFactory extends BaseLayoutFactory {
  double get columnGap;
  double get rowGap;
  bool get expandChildren;

  BaseRowLayoutFactory([Geometry? geometry]) : super(geometry);

  RowLayout build(String label);
}

abstract class BaseColumnLayoutFactory extends BaseLayoutFactory {
  double get columnGap;
  double get rowGap;
  bool get expandChildren;

  BaseColumnLayoutFactory([Geometry? geometry]) : super(geometry);

  ColumnLayout build(String label);
}

abstract class BaseHorizontalSpacerFactory extends BaseLayoutFactory {
  BaseHorizontalSpacerFactory([Geometry? geometry]) : super(geometry);

  HorizontalSpacer build(String label);
}

abstract class BaseVerticalSpacerFactory extends BaseLayoutFactory {
  BaseVerticalSpacerFactory([Geometry? geometry]) : super(geometry);

  VerticalSpacer build(String label);
}
/* endregion */

class VirtualKeyboardElementFactory {
  BaseKeyElementFactory? _baseKeyElementFactory;
  BaseMouseButtonElementFactory? _baseMouseButtonElementFactory;
  BaseTextElementFactory? _baseTextElementFactory;
  BaseTouchpadElementFactory? _baseTouchpadElementFactory;
  BaseFlexLayoutFactory? _baseFlexLayoutFactory;
  BaseRowLayoutFactory? _baseRowLayoutFactory;
  BaseColumnLayoutFactory? _baseColumnLayoutFactory;
  BaseHorizontalSpacerFactory? _baseHorizontalSpacerFactory;
  BaseVerticalSpacerFactory? _baseVerticalSpacerFactory;

  VirtualKeyboardElementFactory() {
    resolveDependencies();
  }

  void resolveDependencies() {
    if (Get.isRegistered<BaseKeyElementFactory>()) {
      _baseKeyElementFactory = Get.find<BaseKeyElementFactory>();
    }
    if (Get.isRegistered<BaseMouseButtonElementFactory>()) {
      _baseMouseButtonElementFactory = Get.find<BaseMouseButtonElementFactory>();
    }
    if (Get.isRegistered<BaseTextElementFactory>()) {
      _baseTextElementFactory = Get.find<BaseTextElementFactory>();
    }
    if (Get.isRegistered<BaseTouchpadElementFactory>()) {
      _baseTouchpadElementFactory = Get.find<BaseTouchpadElementFactory>();
    }
    if (Get.isRegistered<BaseFlexLayoutFactory>()) {
      _baseFlexLayoutFactory = Get.find<BaseFlexLayoutFactory>();
    }
    if (Get.isRegistered<BaseRowLayoutFactory>()) {
      _baseRowLayoutFactory = Get.find<BaseRowLayoutFactory>();
    }
    if (Get.isRegistered<BaseColumnLayoutFactory>()) {
      _baseColumnLayoutFactory = Get.find<BaseColumnLayoutFactory>();
    }
    if (Get.isRegistered<BaseHorizontalSpacerFactory>()) {
      _baseHorizontalSpacerFactory = Get.find<BaseHorizontalSpacerFactory>();
    }
    if (Get.isRegistered<BaseVerticalSpacerFactory>()) {
      _baseVerticalSpacerFactory = Get.find<BaseVerticalSpacerFactory>();
    }
  }

  BaseKeyElement buildKeyElement(String label, BaseAction action,
      {BaseAction? doubleTapAction, BaseAction? holdAction}) {
    return _baseKeyElementFactory!
        .build(label, action, doubleTapAction: doubleTapAction, holdAction: holdAction);
  }

  BaseMouseButtonElement buildMouseButtonElement(String label, ac) {
    return _baseMouseButtonElementFactory!.build(label);
  }
}

class VirtualKeyboardXMLParser {
  final XmlDocument _document;

  /// /keyboard
  XmlElement get _root => _document.rootElement;

  VirtualKeyboardXMLParser(String xmlContent) : _document = XmlDocument.parse(xmlContent);

  factory VirtualKeyboardXMLParser.fromFile(String fileName) {
    return VirtualKeyboardXMLParser(_readFileContent(fileName));
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
  XmlElement getDefItem(String nodeName) =>
      getDefs().firstWhere((def) => def.name.local == nodeName);

  /// /keyboard/defs/def/[tag]/@[attr]
  String? getDefItemAttribute(String nodeName, String attrName) =>
      getDefItem(nodeName).getAttribute(attrName);

  /* endregion Defs */

  /// /keyboard/root
  XmlElement getKeyboardRoot() => _root.findElements('root').first;
}

/*
class VirtualKeyboardRenderer {
  final VirtualKeyboardXMLParser _parser;
  final VirtualKeyboardElementFactory _elementFactory;

  VirtualKeyboardRenderer(this._parser, this._elementFactory);

  BaseLayout render() {
    final root = _parser._root;
    final menus = _parser.getMenus();
    final rootColumns = _parser.getRootColumns();
}
*/
