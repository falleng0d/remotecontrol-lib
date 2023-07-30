import 'package:xml/xml.dart';

import '../../elements/element_base.dart';
import '../../elements/layouts.dart';
import '../../values/props.dart';
import '../factory.dart';

abstract class BaseLayoutFactory<E extends BaseElement, T extends BaseElementProps,
    F extends XmlNodeToObjectFactory<T>> extends BaseElementFactory<E, T, F> {
  BaseLayoutFactory(props, propsLoader) : super(props, propsLoader);

  @override

  /// Builds element using [props] as default parameters and optionally loading properties
  /// from a [XmlElement] node. Additionallt accepts [overrides] to override default
  /// properties. [overrides] will replace properties found in [node].
  E build({XmlElement? node, T? overrides, List<BaseElement>? children});
}

typedef BaseFlexLayoutFactory
    = BaseLayoutFactory<FlexLayout, FlexLayoutProps, FlexLayoutPropsFactory>;

typedef BaseRowLayoutFactory
    = BaseLayoutFactory<RowLayout, RowLayoutProps, RowLayoutPropsFactory>;

typedef BaseColumnLayoutFactory
    = BaseLayoutFactory<ColumnLayout, ColumnLayoutProps, ColumnLayoutPropsFactory>;
