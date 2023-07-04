// ignore_for_file: camel_case_types

import 'package:xml/xml.dart';

typedef double_opt = double?;
typedef bool_opt = bool?;
typedef int_opt = int?;
typedef String_opt = String?;

extension KeyboardXmlElementHelpers on XmlElement {
  String get tag => name.local;

  List<String> get _layoutTypes =>
      ['row', 'column', 'flex', 'horizontal-spacer', 'vertical-spacer'];
  List<String> get _elementTypes => ['key', 'button', 'text', 'touchpad'];

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
