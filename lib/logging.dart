// © 2022 Daily, Co. All Rights Reserved

import 'package:logging/logging.dart';

void initLogging() {
  final levelName = const String.fromEnvironment('logLevel', defaultValue: 'INFO').toUpperCase();
  Logger.root
    ..level = Level.LEVELS.firstWhere((level) => level.name == levelName)
    ..onRecord.listen((record) {
      final error = record.error == null ? '' : '\n${record.error}\n${record.stackTrace}';
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}$error');
    });
}

Logger get logger => Logger('DailyFlutterExample');
