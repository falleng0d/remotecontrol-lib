import 'package:flutter/foundation.dart';

mixin Subscribable<T extends Enum, Payload> {
  final Map<T, List<void Function(T, Payload)>> _listeners = {};

  void subscribe(T level, void Function(T, Payload) callback) {
    _listeners.putIfAbsent(level, () => []).add(callback);
  }

  void subscribeAll(List<T> levels, void Function(T, Payload) callback) {
    for (final level in levels) {
      subscribe(level, callback);
    }
  }

  void unsubscribe(T level, void Function(T, Payload) callback) {
    _listeners[level]?.remove(callback);
  }

  void unsubscribeAll(List<T> events, void Function(T, Payload) callback) {
    for (final event in events) {
      unsubscribe(event, callback);
    }
  }

  @protected
  void dispatch(T messageLevel, Payload message) {
    _listeners[messageLevel]?.forEach((callback) => callback(messageLevel, message));
  }
}
