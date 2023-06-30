import 'package:flutter/rendering.dart';
import 'package:remotecontrol_lib/extension/xml_element.dart';
import 'package:xml/xml.dart';

import '../keyboard.dart';

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
