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

    // border radius
    final double? b0 = node.getIfAttributeValue('b');
    final double? br0 = node.getIfAttributeValue('br');
    final double? bl0 = node.getIfAttributeValue('bl');
    final double? bt0 = node.getIfAttributeValue('bt');
    final double? bb0 = node.getIfAttributeValue('bb');

    final Radius? b = b0 != null ? Radius.circular(b0) : null;
    final Radius? br = br0 != null ? Radius.circular(br0) : null;
    final Radius? bl = bl0 != null ? Radius.circular(bl0) : null;
    final Radius? bt = bt0 != null ? Radius.circular(bt0) : null;
    final Radius? bb = bb0 != null ? Radius.circular(bb0) : null;

    final double? btl0 = node.getIfAttributeValue('btl');
    final double? btr0 = node.getIfAttributeValue('btr');
    final double? bbl0 = node.getIfAttributeValue('bbl');
    final double? bbr0 = node.getIfAttributeValue('bbr');

    final Radius? btl = btl0 != null ? Radius.circular(btl0) : null;
    final Radius? btr = btr0 != null ? Radius.circular(btr0) : null;
    final Radius? bbl = bbl0 != null ? Radius.circular(bbl0) : null;
    final Radius? bbr = bbr0 != null ? Radius.circular(bbr0) : null;

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
      borderRadius: BorderRadius.only(
        topLeft: node.getAttributeValue<Radius>(
            'btl', btl ?? bt ?? bl ?? b ?? borderRadius?.topLeft ?? Radius.zero),
        topRight: node.getAttributeValue<Radius>(
            'btr', btr ?? bt ?? br ?? b ?? borderRadius?.topRight ?? Radius.zero),
        bottomLeft: node.getAttributeValue<Radius>(
            'bbl', bbl ?? bb ?? bl ?? b ?? borderRadius?.bottomLeft ?? Radius.zero),
        bottomRight: node.getAttributeValue<Radius>(
            'bbr', bbr ?? bb ?? br ?? b ?? borderRadius?.bottomRight ?? Radius.zero),
      ),
    );
  }
}
