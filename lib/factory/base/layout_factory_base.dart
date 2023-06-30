import 'package:remotecontrol_lib/factory/props.dart';

import '../../keyboard.dart';
import 'element_factory_base.dart';

abstract class BaseLayoutFactory<T extends BaseElementProps,
    E extends XmlNodeToObjectFactory<T>> extends BaseElementFactory<T, E> {
  BaseLayoutFactory(props, propsLoader) : super(props, propsLoader);
}

abstract class BaseFlexLayoutFactory
    extends BaseLayoutFactory<FlexLayoutProps, FlexLayoutPropsFactory> {
  BaseFlexLayoutFactory(props, propsLoader) : super(props, propsLoader);

  FlexLayout build(
      {String? label, FlexLayoutProps? overrides, List<BaseElement>? children});
}

abstract class BaseRowLayoutFactory
    extends BaseLayoutFactory<RowLayoutProps, RowLayoutPropsFactory> {
  BaseRowLayoutFactory(props, propsLoader) : super(props, propsLoader);

  RowLayout build(
      {String? label, RowLayoutProps? overrides, List<BaseElement>? children});
}

abstract class BaseColumnLayoutFactory
    extends BaseLayoutFactory<ColumnLayoutProps, ColumnLayoutPropsFactory> {
  BaseColumnLayoutFactory(props, propsLoader) : super(props, propsLoader);

  ColumnLayout build(
      {String? label, ColumnLayoutProps? overrides, List<BaseElement>? children});
}

abstract class BaseHorizontalSpacerFactory
    extends BaseLayoutFactory<HorizontalSpacerProps, HorizontalSpacerPropsFactory> {
  BaseHorizontalSpacerFactory(props, propsLoader) : super(props, propsLoader);

  HorizontalSpacer build({String? label, HorizontalSpacerProps? overrides});
}

abstract class BaseVerticalSpacerFactory
    extends BaseLayoutFactory<VerticalSpacerProps, VerticalSpacerPropsFactory> {
  BaseVerticalSpacerFactory(props, propsLoader) : super(props, propsLoader);

  VerticalSpacer build({String? label, VerticalSpacerProps? overrides});
}
