import 'package:flutter/rendering.dart';
import 'package:remotecontrol_lib/extension/xml_element.dart';
import 'package:xml/xml.dart';

import '../keyboard.dart';

/// [GeometryXMLNodeDeserializer] adds utility method to [Geometry]
/// that allows load attributes from a [XmlElement] and create a new
/// [Geometry] instance with those attributes.
extension GeometryXMLNodeDeserializer on Geometry {
  Geometry withAttributes(XmlElement node) {
    final double? p = node.getIfAttributeValue('p');
    final double? m = node.getIfAttributeValue('m');
    final double? px = p ?? node.getIfAttributeValue('px');
    final double? py = p ?? node.getIfAttributeValue('py');
    final double? mx = m ?? node.getIfAttributeValue('mx');
    final double? my = m ?? node.getIfAttributeValue('my');

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
        node.getAttributeValue('pl', px ?? padding?.left) ?? 0,
        node.getAttributeValue('pt', py ?? padding?.top) ?? 0,
        node.getAttributeValue('pr', px ?? padding?.right) ?? 0,
        node.getAttributeValue('pb', py ?? padding?.bottom) ?? 0,
      ),
      margin: EdgeInsets.fromLTRB(
        node.getAttributeValue('ml', mx ?? margin?.left) ?? 0,
        node.getAttributeValue('mt', my ?? margin?.top) ?? 0,
        node.getAttributeValue('mr', mx ?? margin?.right) ?? 0,
        node.getAttributeValue('mb', my ?? margin?.bottom) ?? 0,
      ),
    );
  }
}
