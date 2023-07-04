import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:yaml/yaml.dart';

void main() {
  asyncMain().then((value) => exit(0));
}

Future asyncMain() async {
  // load yaml file from ./example/example.yaml
  var file = File('./example/keyboard_layout.yaml');
  var content = await file.readAsString();

  var doc = loadYaml(content);
  print(json.encode(doc));
}
