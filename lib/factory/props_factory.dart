import 'package:remotecontrol_lib/extension/geometry.dart';
import 'package:remotecontrol_lib/extension/xml_element.dart';
import 'package:xml/xml.dart';

import '../keyboard.dart';

abstract class XmlNodeToObjectFactory<T> {
  T load(XmlElement node, {T? defaults});
  T merge(T into, {required XmlElement node});
}

class GeometryPropsFactory extends XmlNodeToObjectFactory<Geometry> {
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

class KeyElementPropsFactory extends XmlNodeToObjectFactory<KeyElementProps> {
  @override
  KeyElementProps load(XmlElement node, {KeyElementProps? defaults}) {
    final actuationTypeName = node.getAttributeValue<String?>('type', null);
    final actuationType = actuationTypeName != null
        ? KeyActuationType.values.firstWhere((e) => e.name == actuationTypeName)
        : defaults?.actuationType;

    return KeyElementProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
      actuationType: actuationType,
      toggle: node.getAttributeValue('toggle', defaults?.toggle),
      keyRep: node.getAttributeValue('key-rep', defaults?.keyRep),
      keyRepeatDelay:
          node.getAttributeValue('key-repeat-delay', defaults?.keyRepeatDelay),
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
    final actuationTypeName = node.getAttributeValue<String?>('type', null);
    final actuationType = actuationTypeName != null
        ? KeyActuationType.values.firstWhere((e) => e.toString() == actuationTypeName)
        : into.actuationType;

    return KeyElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
      toggle: node.getAttributeValue('toggle', into.toggle),
      actuationType: actuationType,
      keyRep: node.getAttributeValue('key-rep', into.keyRep),
      keyRepeatDelay: node.getAttributeValue('key-repeat-delay', into.keyRepeatDelay),
      holdTimeThreshold:
          node.getAttributeValue('hold-time-threshold', into.holdTimeThreshold),
      doubleTapThershold:
          node.getAttributeValue('double-tap-threshold', into.doubleTapThershold),
      // doubleTapAction: node.getAttributeValue('double-tap-action', into.doubleTapAction),
      // holdAction: node.getAttributeValue('hold-action', into.holdAction),
    );
  }
}

class MouseElementPropsFactory extends XmlNodeToObjectFactory<MouseElementProps> {
  @override
  MouseElementProps load(XmlElement node, {MouseElementProps? defaults}) {
    return MouseElementProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
    );
  }

  @override
  MouseElementProps merge(MouseElementProps into, {required XmlElement node}) {
    return MouseElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
    );
  }
}

class TextElementPropsFactory extends XmlNodeToObjectFactory<TextElementProps> {
  @override
  TextElementProps load(XmlElement node, {TextElementProps? defaults}) {
    return TextElementProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
    );
  }

  @override
  TextElementProps merge(TextElementProps into, {required XmlElement node}) {
    return TextElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
    );
  }
}

class TouchpadElementPropsFactory extends XmlNodeToObjectFactory<TouchpadElementProps> {
  @override
  TouchpadElementProps load(XmlElement node, {TouchpadElementProps? defaults}) {
    return TouchpadElementProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
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
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
      scrollbar: node.getAttributeValue('scrollbar', into.scrollbar),
      mouseButtons: node.getAttributeValue('mouse-buttons', into.mouseButtons),
      tapToClick: node.getAttributeValue('tap-to-click', into.tapToClick),
      doubleTapAndHold:
          node.getAttributeValue('double-tap-and-hold', into.doubleTapAndHold),
    );
  }
}

class FlexLayoutPropsFactory extends XmlNodeToObjectFactory<FlexLayoutProps> {
  @override
  FlexLayoutProps load(XmlElement node, {FlexLayoutProps? defaults}) {
    return FlexLayoutProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
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
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
      direction: node.getAttributeValue('direction', into.direction),
      columnGap: node.getAttributeValue('column-gap', into.columnGap),
      rowGap: node.getAttributeValue('row-gap', into.rowGap),
      expandChildren: node.getAttributeValue('expand-children', into.expandChildren),
    );
  }
}

class RowLayoutPropsFactory extends XmlNodeToObjectFactory<RowLayoutProps> {
  @override
  RowLayoutProps load(XmlElement node, {RowLayoutProps? defaults}) {
    return RowLayoutProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
      columnGap: node.getAttributeValue('column-gap', defaults?.columnGap),
      expandChildren: node.getAttributeValue('expand-children', defaults?.expandChildren),
    );
  }

  @override
  RowLayoutProps merge(RowLayoutProps into, {required XmlElement node}) {
    return RowLayoutProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
      columnGap: node.getAttributeValue('column-gap', into.columnGap),
      expandChildren: node.getAttributeValue('expand-children', into.expandChildren),
    );
  }
}

class ColumnLayoutPropsFactory extends XmlNodeToObjectFactory<ColumnLayoutProps> {
  @override
  ColumnLayoutProps load(XmlElement node, {ColumnLayoutProps? defaults}) {
    return ColumnLayoutProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
      rowGap: node.getAttributeValue('row-gap', defaults?.rowGap),
      expandChildren: node.getAttributeValue('expand-children', defaults?.expandChildren),
    );
  }

  @override
  ColumnLayoutProps merge(ColumnLayoutProps into, {required XmlElement node}) {
    return ColumnLayoutProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
      rowGap: node.getAttributeValue('row-gap', into.rowGap),
      expandChildren: node.getAttributeValue('expand-children', into.expandChildren),
    );
  }
}

class HorizontalSpacerPropsFactory extends XmlNodeToObjectFactory<HorizontalSpacerProps> {
  @override
  HorizontalSpacerProps load(XmlElement node, {HorizontalSpacerProps? defaults}) {
    return HorizontalSpacerProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
    );
  }

  @override
  HorizontalSpacerProps merge(HorizontalSpacerProps into, {required XmlElement node}) {
    return HorizontalSpacerProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
    );
  }
}

class VerticalSpacerPropsFactory extends XmlNodeToObjectFactory<VerticalSpacerProps> {
  @override
  VerticalSpacerProps load(XmlElement node, {VerticalSpacerProps? defaults}) {
    return VerticalSpacerProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
    );
  }

  @override
  VerticalSpacerProps merge(VerticalSpacerProps into, {required XmlElement node}) {
    return VerticalSpacerProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
    );
  }
}
