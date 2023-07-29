import 'package:get/get.dart';
import 'package:remotecontrol_lib/elements/element.dart';
import 'package:remotecontrol_lib/keyboard.dart';
import 'package:remotecontrol_lib/values/color.dart';
import 'package:xml/xml.dart';

import '../factory.dart';

class KeyboardElementFactory {
  /* region Fields */
  BaseKeyElementFactory? __baseKeyElementFactory;
  BaseHotkeyElementFactory? __baseHotkeyElementFactory;
  BaseToggleElementFactory? __baseToggleElementFactory;
  BaseMouseButtonElementFactory? __baseMouseButtonElementFactory;
  BaseTextElementFactory? __baseTextElementFactory;
  BaseTouchpadElementFactory? __baseTouchpadElementFactory;

  BaseFlexLayoutFactory? __baseFlexLayoutFactory;
  BaseRowLayoutFactory? __baseRowLayoutFactory;
  BaseColumnLayoutFactory? __baseColumnLayoutFactory;
  BaseHorizontalSpacerFactory? __baseHorizontalSpacerFactory;
  BaseVerticalSpacerFactory? __baseVerticalSpacerFactory;

  ColorFactory? __colorFactory;
  BaseSwitchFactory? __baseSwitchFactory;
  /* endregion Fields */

  /* region Getters */
  BaseKeyElementFactory get _baseKeyElementFactory {
    if (__baseKeyElementFactory == null) {
      throw Exception('BaseKeyElementFactory is not registered');
    }

    return __baseKeyElementFactory!;
  }

  BaseHotkeyElementFactory get _baseHotkeyElementFactory {
    if (__baseHotkeyElementFactory == null) {
      throw Exception('BaseHotkeyElementFactory is not registered');
    }

    return __baseHotkeyElementFactory!;
  }

  BaseToggleElementFactory get _baseToggleElememtFactory {
    if (__baseToggleElementFactory == null) {
      throw Exception('BaseToggleElementFactory is not registered');
    }

    return __baseToggleElementFactory!;
  }

  BaseMouseButtonElementFactory get _baseMouseButtonElementFactory {
    if (__baseMouseButtonElementFactory == null) {
      throw Exception('BaseMouseButtonElementFactory is not registered');
    }

    return __baseMouseButtonElementFactory!;
  }

  BaseTextElementFactory get _baseTextElementFactory {
    if (__baseTextElementFactory == null) {
      throw Exception('BaseTextElementFactory is not registered');
    }

    return __baseTextElementFactory!;
  }

  BaseTouchpadElementFactory get _baseTouchpadElementFactory {
    if (__baseTouchpadElementFactory == null) {
      throw Exception('BaseTouchpadElementFactory is not registered');
    }

    return __baseTouchpadElementFactory!;
  }

  BaseFlexLayoutFactory get _baseFlexLayoutFactory {
    if (__baseFlexLayoutFactory == null) {
      throw Exception('BaseFlexLayoutFactory is not registered');
    }

    return __baseFlexLayoutFactory!;
  }

  BaseRowLayoutFactory get _baseRowLayoutFactory {
    if (__baseRowLayoutFactory == null) {
      throw Exception('BaseRowLayoutFactory is not registered');
    }

    return __baseRowLayoutFactory!;
  }

  BaseColumnLayoutFactory get _baseColumnLayoutFactory {
    if (__baseColumnLayoutFactory == null) {
      throw Exception('BaseColumnLayoutFactory is not registered');
    }

    return __baseColumnLayoutFactory!;
  }

  BaseHorizontalSpacerFactory get _baseHorizontalSpacerFactory {
    if (__baseHorizontalSpacerFactory == null) {
      throw Exception('BaseHorizontalSpacerFactory is not registered');
    }

    return __baseHorizontalSpacerFactory!;
  }

  BaseVerticalSpacerFactory get _baseVerticalSpacerFactory {
    if (__baseVerticalSpacerFactory == null) {
      throw Exception('BaseVerticalSpacerFactory is not registered');
    }

    return __baseVerticalSpacerFactory!;
  }

  ColorFactory get _colorFactory {
    if (__colorFactory == null) {
      throw Exception('ColorFactory is not registered');
    }

    return __colorFactory!;
  }

  BaseSwitchFactory get _baseSwitchFactory {
    if (__baseSwitchFactory == null) {
      throw Exception('BaseSwitchFactory is not registered');
    }

    return __baseSwitchFactory!;
  }
  /* endregion Getters */

  KeyboardElementFactory() {
    resolveDependencies();
  }

  void resolveDependencies() {
    if (Get.isRegistered<BaseKeyElementFactory>()) {
      __baseKeyElementFactory = Get.find<BaseKeyElementFactory>();
    }
    if (Get.isRegistered<BaseHotkeyElementFactory>()) {
      __baseHotkeyElementFactory = Get.find<BaseHotkeyElementFactory>();
    }
    if (Get.isRegistered<BaseToggleElementFactory>()) {
      __baseToggleElementFactory = Get.find<BaseToggleElementFactory>();
    }
    if (Get.isRegistered<BaseMouseButtonElementFactory>()) {
      __baseMouseButtonElementFactory = Get.find<BaseMouseButtonElementFactory>();
    }
    if (Get.isRegistered<BaseTextElementFactory>()) {
      __baseTextElementFactory = Get.find<BaseTextElementFactory>();
    }
    if (Get.isRegistered<BaseTouchpadElementFactory>()) {
      __baseTouchpadElementFactory = Get.find<BaseTouchpadElementFactory>();
    }

    if (Get.isRegistered<BaseFlexLayoutFactory>()) {
      __baseFlexLayoutFactory = Get.find<BaseFlexLayoutFactory>();
    }
    if (Get.isRegistered<BaseRowLayoutFactory>()) {
      __baseRowLayoutFactory = Get.find<BaseRowLayoutFactory>();
    }
    if (Get.isRegistered<BaseColumnLayoutFactory>()) {
      __baseColumnLayoutFactory = Get.find<BaseColumnLayoutFactory>();
    }
    if (Get.isRegistered<BaseHorizontalSpacerFactory>()) {
      __baseHorizontalSpacerFactory = Get.find<BaseHorizontalSpacerFactory>();
    }
    if (Get.isRegistered<BaseVerticalSpacerFactory>()) {
      __baseVerticalSpacerFactory = Get.find<BaseVerticalSpacerFactory>();
    }

    if (Get.isRegistered<ColorFactory>()) {
      __colorFactory = Get.find<ColorFactory>();
    }
    if (Get.isRegistered<BaseSwitchFactory>()) {
      __baseSwitchFactory = Get.find<BaseSwitchFactory>();
    }
  }

  /* region Misc Builders */
  KeyColor? _buildColor(XmlElement node) {
    final colorName = node.getAttribute('color');
    if (colorName == null) return null;

    return _colorFactory.build(colorName);
  }

  Switch buildSwitch(
    XmlElement node, {
    String? label,
    required String switchId,
    required bool initiaState,
    required List<BaseElement> children,
  }) {
    return _baseSwitchFactory.build(
      node,
      label: label,
      switchId: switchId,
      initiaState: initiaState,
      children: children,
    );
  }
  /* endregion Misc Builders */

  /* region Element Builders */
  BaseKeyElement buildKeyElement(
    XmlElement node,
    covariant BaseKeyAction action, {
    String label = 'key',
  }) {
    // Load color
    return _baseKeyElementFactory.build(
      action,
      label: label,
      overrides: _baseKeyElementFactory.propsLoader.merge(
        _baseKeyElementFactory.props,
        node: node,
        color: _buildColor(node),
      ),
    );
  }

  BaseHotkeyElement buildHotkeyElement(
    XmlElement node,
    String hotkey,
    covariant BaseHotkeyAction action, {
    required String label,
  }) {
    return _baseHotkeyElementFactory.build(
      action,
      label: label,
      overrides: _baseHotkeyElementFactory.propsLoader.merge(
        _baseHotkeyElementFactory.props,
        node: node,
      ),
    );
  }

  BaseToggleElement buildToggleElememt(
    XmlElement node,
    String switchId,
    covariant BaseToggleAction action, {
    String label = 'toggle',
  }) {
    return _baseToggleElememtFactory.build(
      action,
      switchId,
      label: label,
      overrides: _baseToggleElememtFactory.propsLoader.merge(
        _baseToggleElememtFactory.props,
        node: node,
        color: _buildColor(node),
      ),
    );
  }

  BaseButtonElement buildMouseButtonElement(
    XmlElement node,
    covariant BaseAction<BaseButtonActionContext> action, {
    String label = 'mouseButton',
  }) {
    return _baseMouseButtonElementFactory.build(action,
        label: label,
        overrides: _baseMouseButtonElementFactory.propsLoader.merge(
          _baseMouseButtonElementFactory.props,
          node: node,
        ));
  }

  BaseTextElement buildTextElement(XmlElement node, String label) {
    return _baseTextElementFactory.build(
      label,
      overrides: _baseTextElementFactory.propsLoader.merge(
        _baseTextElementFactory.props,
        node: node,
      ),
    );
  }

  BaseTouchpadElement buildTouchpadElement(
    XmlElement node, {
    String label = 'touchpad',
    required BaseMouseMoveAction touchpadMoveAction,
    required BaseMouseButtonAction tapAction,
    required BaseMouseButtonAction rightTapAction,
  }) {
    var actions = TouchpadActions(
      touchpadMove: touchpadMoveAction,
      tap: tapAction,
      rightTap: rightTapAction,
    );

    return _baseTouchpadElementFactory.build(
      actions,
      label: label,
      overrides: _baseTouchpadElementFactory.propsLoader.merge(
        _baseTouchpadElementFactory.props,
        node: node,
      ),
    );
  }
  /* endregion Element Builders */

  /* region Layout Builders */
  FlexLayout buildFlexLayout(
    XmlElement node, {
    String label = 'flexLayout',
    List<BaseElement> children = const [],
  }) {
    return _baseFlexLayoutFactory.build(
      label: label,
      children: children,
      overrides: _baseFlexLayoutFactory.propsLoader
          .merge(_baseFlexLayoutFactory.props, node: node),
    );
  }

  RowLayout buildRowLayout(
    XmlElement node, {
    String label = 'rowLayout',
    List<BaseElement> children = const [],
  }) {
    return _baseRowLayoutFactory.build(
      label: label,
      children: children,
      overrides: _baseRowLayoutFactory.propsLoader.merge(
        _baseRowLayoutFactory.props,
        node: node,
      ),
    );
  }

  ColumnLayout buildColumnLayout(
    XmlElement node, {
    String label = 'columnLayout',
    List<BaseElement> children = const [],
  }) {
    return _baseColumnLayoutFactory.build(
      label: label,
      children: children,
      overrides: _baseColumnLayoutFactory.propsLoader.merge(
        _baseColumnLayoutFactory.props,
        node: node,
      ),
    );
  }

  HorizontalSpacer buildHorizontalSpacer(
    XmlElement node, {
    String label = 'horizontalSpacer',
  }) {
    return _baseHorizontalSpacerFactory.build(
      label: label,
      overrides: _baseHorizontalSpacerFactory.propsLoader.merge(
        _baseHorizontalSpacerFactory.props,
        node: node,
      ),
    );
  }

  VerticalSpacer buildVerticalSpacer(
    XmlElement node, {
    String label = 'verticalSpacer',
  }) {
    return _baseVerticalSpacerFactory.build(
      label: label,
      overrides: _baseVerticalSpacerFactory.propsLoader.merge(
        _baseVerticalSpacerFactory.props,
        node: node,
      ),
    );
  }
  /* endregion Layout Builders */
}
