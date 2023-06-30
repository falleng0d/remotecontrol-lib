import 'package:remotecontrol_lib/factory/props.dart';
import 'package:remotecontrol_lib/mixin/sizeable.dart';

import '../../keyboard.dart';

class BaseElementFactory<T extends BaseElementProps, E extends XmlNodeToObjectFactory<T>>
    with SizeableFactory {
  covariant T props;
  covariant E propsLoader;

  BaseElementFactory(T props, E propsLoader)
      : props = props,
        propsLoader = propsLoader {
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
  TouchpadActions get actions;

  BaseTouchpadElementFactory(props, propsLoader) : super(props, propsLoader);

  BaseTouchpadElement build({String? label, TouchpadElementProps? overrides});
}
