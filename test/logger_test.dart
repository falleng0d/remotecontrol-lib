import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:remotecontrol_lib/logger/logger.dart';

void main() {
  group('Logger Tests', () {
    final logger = Logger.instance();

    test('Test default level is debug', () {
      expect(logger.defaultLevel, Level.debug);
    });

    test('Test logging with default level', () {
      final messages = <String>[];
      logger.subscribe(Level.debug, (level, message) => messages.add(message));

      logger.log('test');

      expect(messages.length, 1);
      expect(messages.first.contains('test'), true);
    });

    test('Test logging with custom level', () {
      final messages = <String>[];
      logger.subscribe(Level.warning, (level, message) => messages.add(message));

      logger.log('test', level: Level.warning);

      expect(messages.length, 1);
      expect(messages.first.contains('test'), true);
    });

    test('Test logging with no subscribers', () {
      final messages = <String>[];
      fn(level, message) => messages.add(message);

      logger.subscribe(Level.warning, fn);
      logger.unsubscribe(Level.warning, fn);

      logger.log('test', level: Level.warning);

      expect(messages.length, 0);
    });

    test('Test formatting', () {
      logger.settings.logFormat = '[%date%] [%level%] %message%';
      logger.settings.dateFormat = DateFormat('MM-dd-yyyy HH:mm:ss');

      final formattedMessage = logger.format('test', Level.debug);

      expect(formattedMessage.startsWith('[', 0), true);
      expect(formattedMessage.endsWith('] test'), true);
    });
  });
}
