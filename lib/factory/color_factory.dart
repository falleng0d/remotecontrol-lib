import 'package:remotecontrol_lib/values/color.dart';
import 'package:xml/xml.dart';

class ColorFactory {
  final KeyColor _defaultColor;
  final Map<String, KeyColor> _customColors;

  get defaultColor => _defaultColor;

  static ColorFactory fromDefs(XmlElement defsRoot) {
    throw UnimplementedError();
  }

  ColorFactory({
    required KeyColor defaultColor,
    var colors = const <ColorGroup, KeyColor>{},
    var customColors = const <String, KeyColor>{},
  })  : _defaultColor = defaultColor,
        _customColors = customColors;

  KeyColor build(String? colorName) {
    if (colorName != null) {
      final customColor = _customColors[colorName];
      if (customColor != null) {
        return customColor;
      }
      throw ArgumentError('Invalid color name: $colorName');
    }
    return _defaultColor;
  }
}
