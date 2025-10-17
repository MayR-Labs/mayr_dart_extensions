import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';

void main() {
  print('=== mayr_dart_extensions Examples ===\n');

  // String Extensions
  print('--- String Extensions ---');
  print('Camel Case: ${"hello world".camelCase}'); // helloWorld
  print('Snake Case: ${"hello world".snakeCase}'); // hello_world
  print('Mask: ${"08012345678".mask()}'); // 08*******78
  print('Is Email: ${"test@example.com".isEmail}'); // true
  print('Reverse: ${"hello".reverse()}'); // olleh
  print('');

  // Number Extensions
  print('--- Number Extensions ---');
  print('Clamp Min: ${5.clampMin(10)}'); // 10
  print('Clamp Max: ${20.clampMax(15)}'); // 15
  print('Is Between: ${5.isBetween(1, 10)}'); // true
  print('To Decimal Places: ${3.14159.toDecimalPlaces(2)}'); // 3.14
  print('');

  // DateTime Extensions
  print('--- DateTime Extensions ---');
  final now = DateTime.now();
  print('Is Today: ${now.isToday}'); // true
  print('Is Morning: ${now.isMorning}');
  print('Add 5 days: ${now.addDays(5).format(MayrDateTimeFormats.usDate)}');
  print('Start of day: ${now.startOfDay()}');
  print('');

  // Duration Extensions
  print('--- Duration Extensions ---');
  final duration = Duration(hours: 2, minutes: 30);
  print('Readable: ${duration.toReadableString()}'); // 2h 30m
  print('Humanized: ${duration.humanize()}'); // 2 hours, 30 minutes
  print('');

  // Bool Extensions
  print('--- Bool Extensions ---');
  print('Choose: ${true.choose("Active", "Inactive")}'); // Active
  print('To Int: ${true.toInt()}'); // 1
  print('To Yes/No: ${false.toYesNo()}'); // No
  print('');

  // List Extensions
  print('--- List Extensions ---');
  final numbers = [1, 2, 3, 4, 5];
  print('First or Null: ${numbers.firstOrNull()}'); // 1
  print('Get or Default: ${numbers.getOrDefault(10, 0)}'); // 0
  print('Chunked: ${numbers.chunked(2)}'); // [[1, 2], [3, 4], [5]]
  print('');

  // Map Extensions
  print('--- Map Extensions ---');
  final map = {'a': 1, 'b': 2, 'c': 3};
  print('Get or Null: ${map.getOrNull('d')}'); // null
  print('Get or Default: ${map.getOrDefault('d', 0)}'); // 0
  print('Inverted: ${map.invert()}'); // {1: a, 2: b, 3: c}
  print('');

  // Humanize Extensions
  print('--- Humanize Extensions ---');
  print('Number: ${1234.humanizeNumber()}'); // 1.2k
  print('Ordinal: ${21.humanizeOrdinal()}'); // 21st
  print('Count: ${3.humanizeCount('item')}'); // 3 items
  print('File Size: ${1024.humanizeFileSize()}'); // 1.0 KB
  print('');

  // Delay example
  print('--- Duration Delay ---');
  print('Starting delay...');
  Duration(seconds: 2).delay(() {
    print('Delayed execution after 2 seconds!');
  });
}
