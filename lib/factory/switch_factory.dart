import 'package:xml/xml.dart';

import '../elements/element.dart';

abstract class BaseSwitchFactory {
  Switch build(
    XmlElement node, {
    required String switchId,
    required bool initiaState,
    required List<BaseElement> children,
  });
}
