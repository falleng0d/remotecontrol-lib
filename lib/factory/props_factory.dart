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
        : const Geometry().withAttributes(node);
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
      keyRep: node.getAttributeValue('keyRep', defaults?.keyRep),
      keyRepeatDelay: node.getAttributeValue('keyRepeatDelay', defaults?.keyRepeatDelay),
      holdTimeThreshold:
          node.getAttributeValue('holdTimeThreshold', defaults?.holdTimeThreshold),
      doubleTapThershold:
          node.getAttributeValue('doubleTapThreshold', defaults?.doubleTapThershold),
      modifierId: node.getAttributeValue('mid', defaults?.modifierId),
      disableOnNonModifierPressed: node.getAttributeValue(
          'disableOnNonModifierPressed', defaults?.disableOnNonModifierPressed),
      disableOnSwitchPressed: node.getAttributeValue(
          'disableOnSwitchPressed', defaults?.disableOnSwitchPressed),
      shiftModifierLabel:
          node.getAttributeValue('shiftLabel', defaults?.shiftModifierLabel),
      // doubleTapAction: node.getAttributeValue('doubleTapAction', defaults?.doubleTapAction),
      // holdAction: node.getAttributeValue('holdAction', defaults?.holdAction),
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
      keyRep: node.getAttributeValue('keyRep', into.keyRep),
      keyRepeatDelay: node.getAttributeValue('keyRepeatDelay', into.keyRepeatDelay),
      holdTimeThreshold:
          node.getAttributeValue('holdTimeThreshold', into.holdTimeThreshold),
      doubleTapThershold:
          node.getAttributeValue('doubleTapThreshold', into.doubleTapThershold),
      modifierId: node.getAttributeValue('mid', into.modifierId),
      disableOnNonModifierPressed: node.getAttributeValue(
          'disableOnNonModifierPressed', into.disableOnNonModifierPressed),
      disableOnSwitchPressed:
          node.getAttributeValue('disableOnSwitchPressed', into.disableOnSwitchPressed),
      shiftModifierLabel: node.getAttributeValue('shiftLabel', into.shiftModifierLabel),
      // doubleTapAction: node.getAttributeValue('doubleTapAction', into.doubleTapAction),
      // holdAction: node.getAttributeValue('holdAction', into.holdAction),
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
      mouseButtons: node.getAttributeValue('mouseButtons', defaults?.mouseButtons),
      tapToClick: node.getAttributeValue('tapToClick', defaults?.tapToClick),
      doubleTapAndHold:
          node.getAttributeValue('doubleTapAndHold', defaults?.doubleTapAndHold),
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
      mouseButtons: node.getAttributeValue('mouseButtons', into.mouseButtons),
      tapToClick: node.getAttributeValue('tapToClick', into.tapToClick),
      doubleTapAndHold: node.getAttributeValue('doubleTapAndHold', into.doubleTapAndHold),
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
      columnGap: node.getAttributeValue('columnGap', defaults?.columnGap),
      rowGap: node.getAttributeValue('rowGap', defaults?.rowGap),
      expandChildren: node.getAttributeValue('expandChildren', defaults?.expandChildren),
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
      columnGap: node.getAttributeValue('columnGap', into.columnGap),
      rowGap: node.getAttributeValue('rowGap', into.rowGap),
      expandChildren: node.getAttributeValue('expandChildren', into.expandChildren),
    );
  }
}

class RowLayoutPropsFactory extends XmlNodeToObjectFactory<RowLayoutProps> {
  @override
  RowLayoutProps load(XmlElement node, {RowLayoutProps? defaults}) {
    return RowLayoutProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
      columnGap: node.getAttributeValue('columnGap', defaults?.columnGap),
      expandChildren: node.getAttributeValue('expandChildren', defaults?.expandChildren),
    );
  }

  @override
  RowLayoutProps merge(RowLayoutProps into, {required XmlElement node}) {
    return RowLayoutProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
      columnGap: node.getAttributeValue('columnGap', into.columnGap),
      expandChildren: node.getAttributeValue('expandChildren', into.expandChildren),
    );
  }
}

class ColumnLayoutPropsFactory extends XmlNodeToObjectFactory<ColumnLayoutProps> {
  @override
  ColumnLayoutProps load(XmlElement node, {ColumnLayoutProps? defaults}) {
    return ColumnLayoutProps(
      label: node.getAttributeValue('label', defaults?.label),
      geometry: GeometryPropsFactory().load(node, defaults: defaults?.geometry),
      rowGap: node.getAttributeValue('rowGap', defaults?.rowGap),
      expandChildren: node.getAttributeValue('expandChildren', defaults?.expandChildren),
    );
  }

  @override
  ColumnLayoutProps merge(ColumnLayoutProps into, {required XmlElement node}) {
    return ColumnLayoutProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
      rowGap: node.getAttributeValue('rowGap', into.rowGap),
      expandChildren: node.getAttributeValue('expandChildren', into.expandChildren),
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
