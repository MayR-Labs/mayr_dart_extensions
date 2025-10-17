import 'dart:async';
import 'package:test/test.dart';
import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';

void main() {
  group('StreamExtensions', () {
    test('debounceTime emits after duration of inactivity', () async {
      final controller = StreamController<int>();
      final debounced = controller.stream.debounceTime(Duration(milliseconds: 100));
      final results = <int>[];

      debounced.listen(results.add);

      controller.add(1);
      await Future.delayed(Duration(milliseconds: 50));
      controller.add(2);
      await Future.delayed(Duration(milliseconds: 50));
      controller.add(3);
      await Future.delayed(Duration(milliseconds: 150));

      expect(results, [3]);
      await controller.close();
    });

    test('throttleTime emits at most once per duration', () async {
      final controller = StreamController<int>();
      final throttled = controller.stream.throttleTime(Duration(milliseconds: 100));
      final results = <int>[];

      throttled.listen(results.add);

      controller.add(1);
      controller.add(2);
      await Future.delayed(Duration(milliseconds: 50));
      controller.add(3);
      await Future.delayed(Duration(milliseconds: 100));
      controller.add(4);
      await Future.delayed(Duration(milliseconds: 50));

      expect(results.length, 2);
      expect(results.first, 1);
      await controller.close();
    });

    test('distinctUntilChanged filters consecutive duplicates', () async {
      final controller = StreamController<int>();
      final distinct = controller.stream.distinctUntilChanged();
      final results = <int>[];

      distinct.listen(results.add);

      controller.add(1);
      controller.add(1);
      controller.add(2);
      controller.add(2);
      controller.add(1);
      await Future.delayed(Duration(milliseconds: 50));

      expect(results, [1, 2, 1]);
      await controller.close();
    });

    test('firstWhereOrNull returns matching element', () async {
      final stream = Stream.fromIterable([1, 2, 3, 4, 5]);
      final result = await stream.firstWhereOrNull((x) => x > 3);
      
      expect(result, 4);
    });

    test('firstWhereOrNull returns null when no match', () async {
      final stream = Stream.fromIterable([1, 2, 3]);
      final result = await stream.firstWhereOrNull((x) => x > 5);
      
      expect(result, null);
    });
  });
}
