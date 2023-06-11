import 'package:flutter/foundation.dart';

mixin Subscribable<T extends Enum, Payload> {
  final Map<T, List<void Function(T, Payload)>> _listeners = {};

  void subscribe(T level, void Function(T, Payload) callback) {
    if (_listeners.containsKey(level)) {
      _listeners[level]?.add(callback);
    } else {
      _listeners[level] = [callback];
    }
  }

  void subscribeAll(List<T> levels, void Function(T, Payload) callback) {
    for (final level in levels) {
      subscribe(level, callback);
    }
  }

  void unsubscribe(T level, void Function(T, Payload) callback) {
    _listeners[level]?.remove(callback);
  }

  @protected
  void dispatch(T messageLevel, Payload message) {
    for (final level in _listeners.keys) {
      if (messageLevel.index >= level.index) {
        _listeners[level]?.forEach((callback) => callback(messageLevel, message));
      }
    }
  }
}
