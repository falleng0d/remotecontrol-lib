import 'package:xml/xml.dart';

import '../factory/keyboard_element_factory.dart';
import '../keyboard.dart';
import '../src/virtualkeys.dart';

typedef double_opt = double?;
typedef bool_opt = bool?;
typedef int_opt = int?;
typedef String_opt = String?;

extension KeyboardXmlElementHelpers on XmlElement {
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
      if (attribute == 'infinity') {
        return double.infinity as T;
      }
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

/// [KeyboardNodeRenderer] uses a [KeyboardElementFactory] to render a
/// [XmlElement] into a [BaseElement] displayable widget.
///
/// It starts from the provided node and renders all its children recursively,
/// resulting into a tree of [BaseElement] widgets.
///
/// Only [BaseLayout] elements can have children, so the rendering process
/// will throw an exception if a child is found in a non-layout node.
extension KeyboardNodeRenderer on XmlElement {
  BaseElement render(KeyboardElementFactory factory) {
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

  FlexLayout _renderFlex(KeyboardElementFactory factory) {
    return factory.buildFlexLayout(
      this,
      children: childElements.map((node) => node.render(factory)).toList(),
    );
  }

  RowLayout _renderRow(KeyboardElementFactory factory) {
    return factory.buildRowLayout(
      this,
      children: childElements.map((node) => node.render(factory)).toList(),
    );
  }

  ColumnLayout _renderColumn(KeyboardElementFactory factory) {
    return factory.buildColumnLayout(
      this,
      children: childElements.map((node) => node.render(factory)).toList(),
    );
  }

  HorizontalSpacer _renderHorizontalSpacer(KeyboardElementFactory factory) {
    return factory.buildHorizontalSpacer(this);
  }

  VerticalSpacer _renderVerticalSpacer(KeyboardElementFactory factory) {
    return factory.buildVerticalSpacer(this);
  }

  BaseKeyElement _renderKey(KeyboardElementFactory factory) {
    var keyCode = text;
    final keyCodeAtts = getAttribute('k');
    if (keyCodeAtts != null) {
      keyCode = keyCodeAtts;
    }

    if (keyCode.isEmpty) {
      throw Exception('Key node must have a text with a key code');
    }

    return factory.buildKeyElementWithKeyCode(this, keyCode, label: text);
  }

  BaseElement _renderButton(KeyboardElementFactory factory) {
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

  BaseTextElement _renderText(KeyboardElementFactory factory) {
    final text = this.text;
    if (text.isEmpty) {
      throw Exception('Text node must have a text');
    }

    return factory.buildTextElement(this, text);
  }
}
