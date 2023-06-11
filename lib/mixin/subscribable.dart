import 'package:flutter/foundation.dart';

mixin Subscribable<Type extends Enum, Payload> {
  final Map<Type, List<void Function(Type, Payload)>> _listeners = {};

  void subscribe(Type level, void Function(Type, Payload) callback) {
    if (_listeners.containsKey(level)) {
      _listeners[level]?.add(callback);
    } else {
      _listeners[level] = [callback];
    }
  }

  void unsubscribe(Type level, void Function(Type, Payload) callback) {
    _listeners[level]?.remove(callback);
  }

  @protected
  void dispatch(Type messageLevel, Payload message) {
    for (final level in _listeners.keys) {
      if (messageLevel.index >= level.index) {
        _listeners[level]?.forEach((callback) => callback(messageLevel, message));
      }
    }
  }
}
