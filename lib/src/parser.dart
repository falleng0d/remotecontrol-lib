import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' show EdgeInsets, Key;
import 'package:remotecontrol_lib/keyboard.dart';
import 'package:xml/xml.dart';

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
  BaseElement build(String label);

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

  @override
  BaseKeyElement build(String label);
}

abstract class BaseMouseButtonElementFactory extends BaseElementFactory {
  BaseAction get action;

  BaseMouseButtonElementFactory(BaseAction action, [Geometry? geometry])
      : super(geometry);

  @override
  BaseMouseButtonElement build(String label);
}

abstract class BaseTextElementFactory extends BaseElementFactory {
  @override
  BaseTextElement build(String label);
}

abstract class BaseTouchpadElementFactory extends BaseElementFactory {
  bool get scrollbar;
  bool get mouseButtons;
  bool get tapToClick;
  bool get doubleTapAndHold;
  TouchpadActions get actions;

  @override
  BaseTouchpadElement build(String label);
}
/* endregion */

/* region Abstract Layout Factories */
abstract class BaseLayoutFactory extends BaseElementFactory {}

abstract class BaseFlexLayoutFactory extends BaseLayoutFactory {
  Direction get direction;
  double get columnGap;
  double get rowGap;
  bool get expandChildren;

  @override
  FlexLayout build(String label);
}

abstract class BaseRowLayoutFactory extends BaseLayoutFactory {
  double get columnGap;
  double get rowGap;
  bool get expandChildren;

  @override
  RowLayout build(String label);
}

abstract class BaseColumnLayoutFactory extends BaseLayoutFactory {
  double get columnGap;
  double get rowGap;
  bool get expandChildren;

  @override
  ColumnLayout build(String label);
}

abstract class BaseHorizontalSpacerFactory extends BaseLayoutFactory {
  @override
  HorizontalSpacer build(String label);
}

abstract class BaseVerticalSpacerFactory extends BaseLayoutFactory {
  @override
  VerticalSpacer build(String label);
}
/* endregion */

class VirtualKeyboardXMLParser {
  final XmlDocument _document;

  XmlElement get _root => _document.rootElement;

  VirtualKeyboardXMLParser(String xmlContent) : _document = XmlDocument.parse(xmlContent);

  factory VirtualKeyboardXMLParser.fromFile(String fileName) {
    return VirtualKeyboardXMLParser(_readFileContent(fileName));
  }

  // Helper method to read the file content
  static String _readFileContent(String fileName) {
    return File(fileName).readAsStringSync();
  }

  String? getKeyboardName() {
    return _root.getAttribute('name');
  }

  Iterable<XmlElement> getMenus() {
    return _root.findElements('menus').first.findElements('menu');
  }

  Iterable<XmlElement> getKeysForMenu(String menuId) {
    return _document
        .findAllElements('menu')
        .firstWhere((menu) => menu.getAttribute('id') == menuId)
        .findElements('key');
  }

  Iterable<XmlElement> getRootColumns() {
    return _document.findAllElements('column');
  }

  Iterable<XmlElement> getRowsForColumn(XmlElement column) {
    return column.findElements('row');
  }

  Iterable<XmlElement> getKeysForRow(XmlElement row) {
    return row.findElements('key');
  }

  Iterable<XmlElement> getTouchpadsForRow(XmlElement row) {
    return row.findElements('touchpad');
  }

  Iterable<XmlElement> getHorizontalSpacersForRow(XmlElement row) {
    return row.findElements('horizontal-spacer');
  }
}
