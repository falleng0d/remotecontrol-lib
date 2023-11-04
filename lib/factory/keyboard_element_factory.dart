import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:remotecontrol_lib/elements/element.dart';
import 'package:remotecontrol_lib/values/color.dart';
import 'package:xml/xml.dart';

import '../factory.dart';

abstract class BaseKeyboardElementFactory {
  /* region Fields */
  BaseKeyElementFactory? __baseKeyElementFactory;
  BaseTapElementFactory? __baseTapElementFactory;
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
  @protected
  BaseKeyElementFactory get baseKeyElementFactory {
    if (__baseKeyElementFactory == null) {
      throw Exception('BaseKeyElementFactory is not registered');
    }

    return __baseKeyElementFactory!;
  }

  @protected
  BaseTapElementFactory get baseTapElementFactory {
    if (__baseTapElementFactory == null) {
      throw Exception('BaseTapElementFactory is not registered');
    }

    return __baseTapElementFactory!;
  }

  @protected
  BaseHotkeyElementFactory get baseHotkeyElementFactory {
    if (__baseHotkeyElementFactory == null) {
      throw Exception('BaseHotkeyElementFactory is not registered');
    }

    return __baseHotkeyElementFactory!;
  }

  @protected
  BaseToggleElementFactory get baseToggleElementFactory {
    if (__baseToggleElementFactory == null) {
      throw Exception('BaseToggleElementFactory is not registered');
    }

    return __baseToggleElementFactory!;
  }

  @protected
  BaseMouseButtonElementFactory get baseMouseButtonElementFactory {
    if (__baseMouseButtonElementFactory == null) {
      throw Exception('BaseMouseButtonElementFactory is not registered');
    }

    return __baseMouseButtonElementFactory!;
  }

  @protected
  BaseTextElementFactory get baseTextElementFactory {
    if (__baseTextElementFactory == null) {
      throw Exception('BaseTextElementFactory is not registered');
    }

    return __baseTextElementFactory!;
  }

  @protected
  BaseTouchpadElementFactory get baseTouchpadElementFactory {
    if (__baseTouchpadElementFactory == null) {
      throw Exception('BaseTouchpadElementFactory is not registered');
    }

    return __baseTouchpadElementFactory!;
  }

  @protected
  BaseFlexLayoutFactory get baseFlexLayoutFactory {
    if (__baseFlexLayoutFactory == null) {
      throw Exception('BaseFlexLayoutFactory is not registered');
    }

    return __baseFlexLayoutFactory!;
  }

  @protected
  BaseRowLayoutFactory get baseRowLayoutFactory {
    if (__baseRowLayoutFactory == null) {
      throw Exception('BaseRowLayoutFactory is not registered');
    }

    return __baseRowLayoutFactory!;
  }

  @protected
  BaseColumnLayoutFactory get baseColumnLayoutFactory {
    if (__baseColumnLayoutFactory == null) {
      throw Exception('BaseColumnLayoutFactory is not registered');
    }

    return __baseColumnLayoutFactory!;
  }

  @protected
  BaseHorizontalSpacerFactory get baseHorizontalSpacerFactory {
    if (__baseHorizontalSpacerFactory == null) {
      throw Exception('BaseHorizontalSpacerFactory is not registered');
    }

    return __baseHorizontalSpacerFactory!;
  }

  @protected
  BaseVerticalSpacerFactory get baseVerticalSpacerFactory {
    if (__baseVerticalSpacerFactory == null) {
      throw Exception('BaseVerticalSpacerFactory is not registered');
    }

    return __baseVerticalSpacerFactory!;
  }

  @protected
  ColorFactory get colorFactory {
    if (__colorFactory == null) {
      throw Exception('ColorFactory is not registered');
    }

    return __colorFactory!;
  }

  @protected
  BaseSwitchFactory get baseSwitchFactory {
    if (__baseSwitchFactory == null) {
      throw Exception('BaseSwitchFactory is not registered');
    }

    return __baseSwitchFactory!;
  }
  /* endregion Getters */

  BaseKeyboardElementFactory() {
    resolveDependencies();
  }

  void resolveDependencies() {
    if (Get.isRegistered<BaseKeyElementFactory>()) {
      __baseKeyElementFactory = Get.find<BaseKeyElementFactory>();
    }
    if (Get.isRegistered<BaseTapElementFactory>()) {
      __baseTapElementFactory = Get.find<BaseTapElementFactory>();
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
  KeyColor? buildColor(XmlElement node) {
    final colorName = node.getAttribute('color');
    if (colorName == null) return null;

    return colorFactory.build(colorName);
  }

  Switch buildSwitch(
    XmlElement node, {
    String? label,
    required String switchId,
    required bool initiaState,
    required List<BaseElement> children,
  }) {
    return baseSwitchFactory.build(
      node,
      label: label,
      switchId: switchId,
      initiaState: initiaState,
      children: children,
    );
  }
  /* endregion Misc Builders */

  /* region Element Builders */
  BaseKeyElement buildKeyElement(XmlElement node);
  BaseTapElement buildTapElement(XmlElement node);
  BaseHotkeyElement buildHotkeyElement(XmlElement node);
  BaseToggleElement buildToggleElememt(XmlElement node);
  BaseButtonElement buildMouseButtonElement(XmlElement node);
  BaseTextElement buildTextElement(XmlElement node);
  /* endregion Element Builders */
}
