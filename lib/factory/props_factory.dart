import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:remotecontrol_lib/extension/geometry.dart';
import 'package:remotecontrol_lib/extension/xml_element.dart';
import 'package:xml/xml.dart';

import '../keyboard.dart';

abstract class XmlNodeToObjectFactory<T> {
  T load(XmlElement node, {T? defaults});
}

class GeometryPropsFactory extends XmlNodeToObjectFactory<Geometry> {
  @override
  Geometry load(XmlElement node, {Geometry? defaults}) {
    return (defaults ?? const Geometry()).withAttributes(node);
  }
}

class KeyElementPropsFactory extends XmlNodeToObjectFactory<KeyElementProps> {
  @override
  KeyElementProps load(XmlElement node, {KeyElementProps? defaults}) {
    final initial = (defaults ?? const KeyElementProps());

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
      toggle: node.getIfAttributeValue('toggle'),
      keyRep: node.getIfAttributeValue('keyRep'),
      keyRepeatDelay: node.getIfAttributeValue('keyRepeatDelay'),
      modifierId: node.getIfAttributeValue('mid'),
      switchId: node.getIfAttributeValue('switchId'),
      disableOnNonModifierPressed:
          node.getIfAttributeValue('disableOnNonModifierPressed'),
      disableOnSwitchPressed: node.getIfAttributeValue('disableOnSwitchPressed'),
      shiftModifierLabel: node.getIfAttributeValue('shiftLabel'),
      unshiftOnRelease: node.getIfAttributeValue('unshift'),
      lockOnDoubleTap: node.getIfAttributeValue('lockOnDoubleTap'),
      lockOnHold: node.getIfAttributeValue('lockOnHold'),
    );
  }
}

class TapElementPropsFactory extends XmlNodeToObjectFactory<TapElementProps> {
  @override
  TapElementProps load(XmlElement node, {TapElementProps? defaults}) {
    final initial = (defaults ?? const TapElementProps());

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
      toggle: node.getIfAttributeValue('toggle'),
      modifierId: node.getIfAttributeValue('mid'),
      switchId: node.getIfAttributeValue('switchId'),
      disableOnNonModifierPressed:
          node.getIfAttributeValue('disableOnNonModifierPressed'),
      disableOnSwitchPressed: node.getIfAttributeValue('disableOnSwitchPressed'),
      shiftModifierLabel: node.getIfAttributeValue('shiftLabel'),
      unshiftOnRelease: node.getIfAttributeValue('unshift'),
      lockOnDoubleTap: node.getIfAttributeValue('lockOnDoubleTap'),
      lockOnHold: node.getIfAttributeValue('lockOnHold'),
    );
  }
}

class HotkeyElementPropsFactory extends XmlNodeToObjectFactory<HotkeyElementProps> {
  @override
  HotkeyElementProps load(XmlElement node, {HotkeyElementProps? defaults}) {
    final initial = (defaults ?? const HotkeyElementProps());

    final actuationTypeName = node.getAttributeValue<String?>('type', null);
    final actuationType = actuationTypeName != null
        ? KeyActuationType.values.firstWhere((e) => e.toString() == actuationTypeName)
        : null;

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
      toggle: node.getIfAttributeValue('toggle'),
      actuationType: actuationType,
      keyRep: node.getIfAttributeValue('keyRep'),
      keyRepeatDelay: node.getIfAttributeValue('keyRepeatDelay'),
      shiftModifierLabel: node.getIfAttributeValue('shiftLabel'),
      requireAuthentication: node.getIfAttributeValue('protected'),
    );
  }
}

class ToggleElementPropsFactory extends XmlNodeToObjectFactory<ToggleElementProps> {
  @override
  ToggleElementProps load(XmlElement node, {ToggleElementProps? defaults}) {
    final initial = (defaults ?? const ToggleElementProps());

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
      switchId: node.getIfAttributeValue('switchId'),
      shiftModifierLabel: node.getIfAttributeValue('shiftLabel'),
      untoggleOnNonModifierKeyPressed:
          node.getIfAttributeValue('untoggleOnNonModifierKeyPressed'),
      lockOnDoubleTap: node.getIfAttributeValue('lockOnDoubleTap'),
      lockOnHold: node.getIfAttributeValue('lockOnHold'),
    );
  }
}

class ButtonElementPropsFactory extends XmlNodeToObjectFactory<ButtonElementProps> {
  @override
  ButtonElementProps load(XmlElement node, {ButtonElementProps? defaults}) {
    final initial = (defaults ?? const ButtonElementProps());

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
    );
  }
}

class TextElementPropsFactory extends XmlNodeToObjectFactory<TextElementProps> {
  @override
  TextElementProps load(XmlElement node, {TextElementProps? defaults}) {
    final initial = (defaults ?? const TextElementProps());

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
    );
  }
}

class TouchpadElementPropsFactory extends XmlNodeToObjectFactory<TouchpadElementProps> {
  @override
  TouchpadElementProps load(XmlElement node, {TouchpadElementProps? defaults}) {
    final initial = (defaults ?? const TouchpadElementProps());

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
      scrollbar: node.getIfAttributeValue('scrollbar'),
      mouseButtons: node.getIfAttributeValue('mouseButtons'),
      tapToClick: node.getIfAttributeValue('tapToClick'),
      doubleTapAndHold: node.getIfAttributeValue('doubleTapAndHold'),
    );
  }
}

class FlexLayoutPropsFactory extends XmlNodeToObjectFactory<FlexLayoutProps> {
  @override
  FlexLayoutProps load(XmlElement node, {FlexLayoutProps? defaults}) {
    final initial = (defaults ?? const FlexLayoutProps());

    final crossAxisAlignmentName = node.getIfAttributeValue<String>('cross');
    final crossAxisAlignment = CrossAxisAlignment.values.firstWhereOrNull(
        (n) => n.toString() == 'CrossAxisAlignment.$crossAxisAlignmentName');

    final mainAxisAlignmentName = node.getIfAttributeValue<String>('align');
    final mainAxisAlignment = MainAxisAlignment.values.firstWhereOrNull(
        (n) => n.toString() == 'MainAxisAlignment.$mainAxisAlignmentName');

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
      direction: node.getIfAttributeValue('direction'),
      columnGap: node.getIfAttributeValue('columnGap'),
      rowGap: node.getIfAttributeValue('rowGap'),
      expandChildren: node.getIfAttributeValue('expandChildren'),
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
    );
  }
}

class RowLayoutPropsFactory extends XmlNodeToObjectFactory<RowLayoutProps> {
  @override
  RowLayoutProps load(XmlElement node, {RowLayoutProps? defaults}) {
    final initial = (defaults ?? const RowLayoutProps());

    final crossAxisAlignmentName = node.getIfAttributeValue<String>('cross');
    final crossAxisAlignment = CrossAxisAlignment.values.firstWhereOrNull(
        (n) => n.toString() == 'CrossAxisAlignment.$crossAxisAlignmentName');

    final mainAxisAlignmentName = node.getIfAttributeValue<String>('align');
    final mainAxisAlignment = MainAxisAlignment.values.firstWhereOrNull(
        (n) => n.toString() == 'MainAxisAlignment.$mainAxisAlignmentName');

    print('crossAxisAlignmentName: $crossAxisAlignmentName');
    print('crossAxisAlignment: $crossAxisAlignment');

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
      columnGap: node.getIfAttributeValue('columnGap'),
      expandChildren: node.getIfAttributeValue('expandChildren'),
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
    );
  }
}

class ColumnLayoutPropsFactory extends XmlNodeToObjectFactory<ColumnLayoutProps> {
  @override
  ColumnLayoutProps load(XmlElement node, {ColumnLayoutProps? defaults}) {
    final initial = (defaults ?? const ColumnLayoutProps());

    final crossAxisAlignmentName = node.getIfAttributeValue<String>('cross');
    final crossAxisAlignment = CrossAxisAlignment.values.firstWhereOrNull(
        (n) => n.toString() == 'CrossAxisAlignment.$crossAxisAlignmentName');

    final mainAxisAlignmentName = node.getIfAttributeValue<String>('align');
    final mainAxisAlignment = MainAxisAlignment.values.firstWhereOrNull(
        (n) => n.toString() == 'MainAxisAlignment.$mainAxisAlignmentName');

    print('mainAxisAlignmentName: $mainAxisAlignmentName');
    print('mainAxisAlignment: $mainAxisAlignment');

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
      rowGap: node.getIfAttributeValue('rowGap'),
      expandChildren: node.getIfAttributeValue('expandChildren'),
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
    );
  }
}

class HorizontalSpacerPropsFactory extends XmlNodeToObjectFactory<HorizontalSpacerProps> {
  @override
  HorizontalSpacerProps load(XmlElement node, {HorizontalSpacerProps? defaults}) {
    final initial = (defaults ?? const HorizontalSpacerProps());

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
    );
  }
}

class VerticalSpacerPropsFactory extends XmlNodeToObjectFactory<VerticalSpacerProps> {
  @override
  VerticalSpacerProps load(XmlElement node, {VerticalSpacerProps? defaults}) {
    final initial = (defaults ?? const VerticalSpacerProps());

    return initial.copyWith(
      label: node.getIfAttributeValue('label'),
      geometry: initial.geometry != null
          ? initial.geometry!.withAttributes(node)
          : GeometryPropsFactory().load(node),
    );
  }
}
