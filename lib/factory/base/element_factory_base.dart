import 'package:remotecontrol_lib/factory/props_factory.dart';
import 'package:remotecontrol_lib/mixin/sizeable.dart';

import '../../keyboard.dart';

class BaseElementFactory<T extends BaseElementProps, E extends XmlNodeToObjectFactory<T>>
    with SizeableFactory {
  covariant T props;
  covariant E propsLoader;

  BaseElementFactory(this.props, this.propsLoader) {
    assert(props.isFilled);
  }
}

abstract class BaseKeyElementFactory
    extends BaseElementFactory<KeyElementProps, KeyElementPropsFactory> {
  BaseKeyElementFactory(KeyElementProps props, propsLoader) : super(props, propsLoader);

  BaseKeyElement build(
    covariant BaseAction<BaseKeyActionContext> action, {
    String? label,
    KeyElementProps? overrides,
  });
}

abstract class BaseToggleElementFactory
    extends BaseElementFactory<ToggleElementProps, ToggleElementPropsFactory> {
  BaseToggleElementFactory(ToggleElementProps props, propsLoader)
      : super(props, propsLoader);

  BaseToggleElement build(
    covariant BaseAction<BaseToggleActionContext> action,
    String switchId, {
    String? label,
    ToggleElementProps? overrides,
  });
}

abstract class BaseMouseButtonElementFactory
    extends BaseElementFactory<MouseElementProps, MouseElementPropsFactory> {
  BaseMouseButtonElementFactory(props, propsLoader) : super(props, propsLoader);

  BaseButtonElement build(
    covariant BaseAction<BaseButtonActionContext> action, {
    String? label,
    MouseElementProps? overrides,
  });
}

abstract class BaseTextElementFactory
    extends BaseElementFactory<TextElementProps, TextElementPropsFactory> {
  BaseTextElementFactory(props, propsLoader) : super(props, propsLoader);

  BaseTextElement build(String label, {TextElementProps? overrides});
}

abstract class BaseTouchpadElementFactory
    extends BaseElementFactory<TouchpadElementProps, TouchpadElementPropsFactory> {
  BaseTouchpadElementFactory(props, propsLoader) : super(props, propsLoader);

  BaseTouchpadElement build(TouchpadActions actions,
      {String? label, TouchpadElementProps? overrides});
}
