import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

void main() {
  async_main().then((value) => exit(0));
}

Future async_main() async {
  // load yaml file from ./example/example.yaml
  var file = File('./example/keyboard_layout.yaml');
  var content = await file.readAsString();

  var doc = loadYaml(content);
  print(json.encode(doc));
}
