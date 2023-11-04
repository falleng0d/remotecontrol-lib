import 'package:remotecontrol_lib/factory/props_factory.dart';
import 'package:remotecontrol_lib/mixin/sizeable.dart';
import 'package:xml/xml.dart';

import '../../keyboard.dart';

abstract class BaseElementFactory<E extends BaseElement, T extends BaseElementProps,
    F extends XmlNodeToObjectFactory<T>> with SizeableFactory {
  covariant T props;
  covariant F propsFactory;

  BaseElementFactory(this.props, this.propsFactory);

  /// Builds final props using [props] as default parameters and optionally loading
  /// properties from a [XmlElement] node. Additionallt accepts [overrides] to override
  /// default properties. [overrides] will replace properties found in [node].
  T buildProps({XmlElement? node, T? overrides}) {
    late T result;
    if (node != null && overrides != null) {
      final nodeProps = propsFactory.load(node, defaults: props);
      result = nodeProps.copyFrom(overrides);
    } else if (node != null) {
      result = propsFactory.load(node, defaults: props);
    } else {
      result = overrides != null ? props.copyFrom(overrides) : props;
    }

    assert(result.isFilled, 'ElementProps for $runtimeType is not filled');

    return result;
  }

  /// Builds element using [props] as default parameters and optionally loading properties
  /// from a [XmlElement] node. Additionallt accepts [overrides] to override default
  /// properties. [overrides] will replace properties found in [node].
  E build({XmlElement? node, T? overrides});
}

typedef BaseKeyElementFactory
    = BaseElementFactory<BaseKeyElement, KeyElementProps, KeyElementPropsFactory>;

typedef BaseTapElementFactory
    = BaseElementFactory<BaseTapElement, TapElementProps, TapElementPropsFactory>;

typedef BaseHotkeyElementFactory = BaseElementFactory<BaseHotkeyElement,
    HotkeyElementProps, HotkeyElementPropsFactory>;

typedef BaseToggleElementFactory = BaseElementFactory<BaseToggleElement,
    ToggleElementProps, ToggleElementPropsFactory>;

typedef BaseMouseButtonElementFactory = BaseElementFactory<BaseButtonElement,
    ButtonElementProps, ButtonElementPropsFactory>;

typedef BaseTextElementFactory
    = BaseElementFactory<BaseTextElement, TextElementProps, TextElementPropsFactory>;

typedef BaseTouchpadElementFactory = BaseElementFactory<BaseTouchpadElement,
    TouchpadElementProps, TouchpadElementPropsFactory>;

typedef BaseHorizontalSpacerFactory = BaseElementFactory<HorizontalSpacer,
    HorizontalSpacerProps, HorizontalSpacerPropsFactory>;

typedef BaseVerticalSpacerFactory
    = BaseElementFactory<VerticalSpacer, VerticalSpacerProps, VerticalSpacerPropsFactory>;
