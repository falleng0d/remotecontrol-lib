import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum Level {
  trace,
  debug,
  info,
  warning,
  error,
}

class LoggerSettings {
  Level defaultLevel;
  DateFormat dateFormat;

  /// Tha available [logFormat] variables are:
  /// %level%, %date%, %message%
  String logFormat;

  LoggerSettings(
      {required this.defaultLevel, required this.dateFormat, required this.logFormat});
}

class Logger {
  final Map<Level, List<void Function(Level, String)>> _listeners = {};

  LoggerSettings settings = LoggerSettings(
    defaultLevel: Level.debug,
    dateFormat: DateFormat(DateFormat.HOUR24_MINUTE_SECOND),
    logFormat: '[%level%] %date%: %message%',
  );

  static final Logger _globalInstance = Logger();

  /// The global instance of the logger.
  factory Logger.instance() {
    return _globalInstance;
  }

  Logger({LoggerSettings? settings}) {
    if (settings != null) {
      this.settings = settings;
    }
  }

  Level get defaultLevel => settings.defaultLevel;

  void subscribe(Level level, void Function(Level, String) callback) {
    _listeners.putIfAbsent(level, () => []).add(callback);
  }

  void unsubscribe(Level level, void Function(Level, String) callback) {
    _listeners[level]?.remove(callback);
  }

  void _dispatch(Level messageLevel, String message) {
    for (final level in Level.values.toList()) {
      if (messageLevel.index >= level.index) {
        _listeners[level]?.forEach((callback) => callback(messageLevel, message));
      }
    }
  }

  String _format(String message, Level level) {
    final date = settings.dateFormat.format(DateTime.now());
    final formattedMessage = settings.logFormat
        .replaceAll('%level%', level.name)
        .replaceAll('%date%', date)
        .replaceAll('%message%', message);
    return formattedMessage;
  }

  @visibleForTesting
  String format(String message, Level level) => _format(message, level);

  void log(String message, {Level? level}) {
    var messageLogLevel = level ?? defaultLevel;
    final formattedMessage = _format(message, messageLogLevel);
    _dispatch(messageLogLevel, formattedMessage);
  }

  dynamic debug(String message) => log(message, level: Level.debug);

  dynamic info(String message) => log(message, level: Level.info);

  dynamic warning(String message) => log(message, level: Level.warning);

  dynamic error(String message) => log(message, level: Level.error);

  dynamic trace(String message) => log(message, level: Level.trace);
}

/// Singleton instance of the logger.
final Logger logger = Logger.instance();
