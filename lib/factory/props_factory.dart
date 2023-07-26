import 'package:remotecontrol_lib/extension/geometry.dart';
import 'package:remotecontrol_lib/extension/xml_element.dart';
import 'package:remotecontrol_lib/values/color.dart';
import 'package:xml/xml.dart';

import '../keyboard.dart';

abstract class XmlNodeToObjectFactory<T> {
  T merge(T into, {required XmlElement node});
  T load(XmlElement node, {T? defaults});
}

class GeometryPropsFactory extends XmlNodeToObjectFactory<Geometry> {
  @override
  Geometry merge(Geometry into, {required XmlElement node}) {
    return into.withAttributes(node);
  }

  @override
  Geometry load(XmlElement node, {Geometry? defaults}) {
    return merge(defaults ?? const Geometry(), node: node);
  }
}

class KeyElementPropsFactory extends XmlNodeToObjectFactory<KeyElementProps> {
  @override
  KeyElementProps merge(KeyElementProps into,
      {required XmlElement node, KeyColor? color}) {
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
      modifierId: node.getAttributeValue('mid', into.modifierId),
      switchId: node.getAttributeValue('switchId', into.switchId),
      disableOnNonModifierPressed: node.getAttributeValue(
          'disableOnNonModifierPressed', into.disableOnNonModifierPressed),
      disableOnSwitchPressed:
          node.getAttributeValue('disableOnSwitchPressed', into.disableOnSwitchPressed),
      shiftModifierLabel: node.getAttributeValue('shiftLabel', into.shiftModifierLabel),
      unshiftOnRelease: node.getAttributeValue('unshift', into.unshiftOnRelease),
      lockOnDoubleTap: node.getAttributeValue('lockOnDoubleTap', into.lockOnDoubleTap),
      lockOnHold: node.getAttributeValue('lockOnHold', into.lockOnHold),
      color: color ?? into.color,
    );
  }

  @override
  KeyElementProps load(XmlElement node, {KeyElementProps? defaults, KeyColor? color}) {
    return merge(defaults ?? const KeyElementProps(), node: node, color: color);
  }
}

class HotkeyElementPropsFactory extends XmlNodeToObjectFactory<HotkeyElementProps> {
  @override
  HotkeyElementProps merge(HotkeyElementProps into,
      {required XmlElement node, KeyColor? color}) {
    final actuationTypeName = node.getAttributeValue<String?>('type', null);
    final actuationType = actuationTypeName != null
        ? KeyActuationType.values.firstWhere((e) => e.toString() == actuationTypeName)
        : into.actuationType;

    return HotkeyElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
      actuationType: actuationType,
      keyRep: node.getAttributeValue('keyRep', into.keyRep),
      keyRepeatDelay: node.getAttributeValue('keyRepeatDelay', into.keyRepeatDelay),
      shiftModifierLabel: node.getAttributeValue('shiftLabel', into.shiftModifierLabel),
      color: color ?? into.color,
    );
  }

  @override
  HotkeyElementProps load(XmlElement node,
      {HotkeyElementProps? defaults, KeyColor? color}) {
    return merge(defaults ?? const HotkeyElementProps(), node: node, color: color);
  }
}

class ToggleElementPropsFactory extends XmlNodeToObjectFactory<ToggleElementProps> {
  @override
  ToggleElementProps merge(ToggleElementProps into,
      {required XmlElement node, KeyColor? color}) {
    final actuationTypeName = node.getAttributeValue<String?>('type', null);
    final actuationType = actuationTypeName != null
        ? KeyActuationType.values.firstWhere((e) => e.toString() == actuationTypeName)
        : into.actuationType;

    return ToggleElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
      toggle: node.getAttributeValue('toggle', into.toggle),
      actuationType: actuationType,
      shiftModifierLabel: node.getAttributeValue('shiftLabel', into.shiftModifierLabel),
      untoggleOnNonModifierKeyPressed: node.getAttributeValue(
          'untoggleOnNonModifierKeyPressed', into.untoggleOnNonModifierKeyPressed),
      lockOnDoubleTap: node.getAttributeValue('lockOnDoubleTap', into.lockOnDoubleTap),
      lockOnHold: node.getAttributeValue('lockOnHold', into.lockOnHold),
      color: color ?? into.color,
    );
  }

  @override
  ToggleElementProps load(XmlElement node,
      {ToggleElementProps? defaults, KeyColor? color}) {
    return merge(defaults ?? const ToggleElementProps(), node: node, color: color);
  }
}

class MouseElementPropsFactory extends XmlNodeToObjectFactory<MouseElementProps> {
  @override
  MouseElementProps merge(MouseElementProps into, {required XmlElement node}) {
    return MouseElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
    );
  }

  @override
  MouseElementProps load(XmlElement node, {MouseElementProps? defaults}) {
    return merge(defaults ?? const MouseElementProps(), node: node);
  }
}

class TextElementPropsFactory extends XmlNodeToObjectFactory<TextElementProps> {
  @override
  TextElementProps merge(TextElementProps into, {required XmlElement node}) {
    return TextElementProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
    );
  }

  @override
  TextElementProps load(XmlElement node, {TextElementProps? defaults}) {
    return merge(defaults ?? const TextElementProps(), node: node);
  }
}

class TouchpadElementPropsFactory extends XmlNodeToObjectFactory<TouchpadElementProps> {
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

  @override
  TouchpadElementProps load(XmlElement node, {TouchpadElementProps? defaults}) {
    return merge(defaults ?? const TouchpadElementProps(), node: node);
  }
}

class FlexLayoutPropsFactory extends XmlNodeToObjectFactory<FlexLayoutProps> {
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

  @override
  FlexLayoutProps load(XmlElement node, {FlexLayoutProps? defaults}) {
    return merge(defaults ?? const FlexLayoutProps(), node: node);
  }
}

class RowLayoutPropsFactory extends XmlNodeToObjectFactory<RowLayoutProps> {
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

  @override
  RowLayoutProps load(XmlElement node, {RowLayoutProps? defaults}) {
    return merge(defaults ?? const RowLayoutProps(), node: node);
  }
}

class ColumnLayoutPropsFactory extends XmlNodeToObjectFactory<ColumnLayoutProps> {
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

  @override
  ColumnLayoutProps load(XmlElement node, {ColumnLayoutProps? defaults}) {
    return merge(defaults ?? const ColumnLayoutProps(), node: node);
  }
}

class HorizontalSpacerPropsFactory extends XmlNodeToObjectFactory<HorizontalSpacerProps> {
  @override
  HorizontalSpacerProps merge(HorizontalSpacerProps into, {required XmlElement node}) {
    return HorizontalSpacerProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
    );
  }

  @override
  HorizontalSpacerProps load(XmlElement node, {HorizontalSpacerProps? defaults}) {
    return merge(defaults ?? const HorizontalSpacerProps(), node: node);
  }
}

class VerticalSpacerPropsFactory extends XmlNodeToObjectFactory<VerticalSpacerProps> {
  @override
  VerticalSpacerProps merge(VerticalSpacerProps into, {required XmlElement node}) {
    return VerticalSpacerProps(
      label: node.getAttributeValue('label', into.label),
      geometry: into.geometry != null
          ? GeometryPropsFactory().merge(into.geometry!, node: node)
          : GeometryPropsFactory().load(node),
    );
  }

  @override
  VerticalSpacerProps load(XmlElement node, {VerticalSpacerProps? defaults}) {
    return merge(defaults ?? const VerticalSpacerProps(), node: node);
  }
}
