import 'package:get/get.dart';
import 'package:remotecontrol_lib/keyboard.dart';
import 'package:xml/xml.dart';

import '../factory.dart';
import '../src/virtualkeys.dart';

class KeyboardElementFactory {
  /* region Fields */
  BaseKeyElementFactory? __baseKeyElementFactory;
  BaseMouseButtonElementFactory? __baseMouseButtonElementFactory;
  BaseTextElementFactory? __baseTextElementFactory;
  BaseTouchpadElementFactory? __baseTouchpadElementFactory;

  BaseFlexLayoutFactory? __baseFlexLayoutFactory;
  BaseRowLayoutFactory? __baseRowLayoutFactory;
  BaseColumnLayoutFactory? __baseColumnLayoutFactory;
  BaseHorizontalSpacerFactory? __baseHorizontalSpacerFactory;
  BaseVerticalSpacerFactory? __baseVerticalSpacerFactory;

  BaseKeyActionFactory? __baseKeyActionFactory;
  BaseButtonActionFactory? __baseMouseButtonActionFactory;
  BaseMouseMoveActionFactory? __baseMouseMoveActionFactory;
  /* endregion Fields */

  /* region Getters */
  BaseKeyElementFactory get _baseKeyElementFactory {
    if (__baseKeyElementFactory == null) {
      throw Exception('BaseKeyElementFactory is not registered');
    }

    return __baseKeyElementFactory!;
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

  BaseKeyActionFactory get _baseKeyActionFactory {
    if (__baseKeyActionFactory == null) {
      throw Exception('BaseKeyActionFactory is not registered');
    }

    return __baseKeyActionFactory!;
  }

  BaseButtonActionFactory get _baseMouseButtonActionFactory {
    if (__baseMouseButtonActionFactory == null) {
      throw Exception('BaseMouseButtonActionFactory is not registered');
    }

    return __baseMouseButtonActionFactory!;
  }

  BaseMouseMoveActionFactory get _baseMouseMoveActionFactory {
    if (__baseMouseMoveActionFactory == null) {
      throw Exception('BaseMouseMoveActionFactory is not registered');
    }

    return __baseMouseMoveActionFactory!;
  }
  /* endregion Getters */

  KeyboardElementFactory() {
    resolveDependencies();
  }

  void resolveDependencies() {
    if (Get.isRegistered<BaseKeyElementFactory>()) {
      __baseKeyElementFactory = Get.find<BaseKeyElementFactory>();
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

    if (Get.isRegistered<BaseKeyActionFactory>()) {
      __baseKeyActionFactory = Get.find<BaseKeyActionFactory>();
    }
    if (Get.isRegistered<BaseButtonActionFactory>()) {
      __baseMouseButtonActionFactory = Get.find<BaseButtonActionFactory>();
    }
    if (Get.isRegistered<BaseMouseMoveActionFactory>()) {
      __baseMouseMoveActionFactory = Get.find<BaseMouseMoveActionFactory>();
    }
  }

  /* region Action Builders */
  BaseKeyAction buildKeyAction(String keyCode) {
    return _baseKeyActionFactory.build(keyCode);
  }

  BaseMouseButtonAction buildMouseButtonAction(MouseButtonType button) {
    return _baseMouseButtonActionFactory.build(button);
  }

  BaseMouseMoveAction buildMouseMoveAction() {
    return _baseMouseMoveActionFactory.build();
  }
  /* endregion Action Builders */

  /* region Element Builders */
  BaseKeyElement buildKeyElement(
    XmlElement node,
    covariant BaseKeyAction action, {
    String label = 'key',
  }) {
    return _baseKeyElementFactory.build(
      action,
      label: label,
      overrides: _baseKeyElementFactory.propsLoader.merge(
        _baseKeyElementFactory.props,
        node: node,
      ),
    );
  }

  BaseKeyElement buildKeyElementWithKeyCode(
    XmlElement node,
    String keyCode, {
    String label = 'key',
  }) {
    final action = buildKeyAction(keyCode);
    return buildKeyElement(node, action, label: label);
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

  BaseButtonElement buildMouseButtonElementWithButtonType(
    XmlElement node,
    MouseButtonType button, {
    String label = 'mouseButton',
  }) {
    final action = buildMouseButtonAction(button);
    return buildMouseButtonElement(node, action, label: label);
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

  BaseTouchpadElement buildTouchpadElement(XmlElement node, {String label = 'touchpad'}) {
    var actions = TouchpadActions(
      touchpadMove: buildMouseMoveAction(),
      tap: buildMouseButtonAction(MouseButtonType.LEFT),
      rightTap: buildMouseButtonAction(MouseButtonType.RIGHT),
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
