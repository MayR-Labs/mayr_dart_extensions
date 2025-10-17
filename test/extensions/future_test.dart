import 'dart:async';
import 'package:test/test.dart';
import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';

void main() {
  group('FutureExtensions', () {
    test('timeout completes before timeout', () async {
      final future = Future.delayed(Duration(milliseconds: 50), () => 'result');
      final result = await future.timeout(Duration(seconds: 1));
      
      expect(result, 'result');
    });

    test('timeout throws TimeoutException', () async {
      final future = Future.delayed(Duration(seconds: 2), () => 'result');
      
      expect(
        () => future.timeout(Duration(milliseconds: 50)),
        throwsA(isA<TimeoutException>()),
      );
    });

    test('timeout uses onTimeout callback', () async {
      final future = Future.delayed(Duration(seconds: 2), () => 'result');
      final result = await future.timeout(
        Duration(milliseconds: 50),
        onTimeout: () => 'timeout',
      );
      
      expect(result, 'timeout');
    });

    test('catchError returns default on error', () async {
      final future = Future<String>.error('error');
      final result = await future.catchError((e) => 'default');
      
      expect(result, 'default');
    });

    test('thenMap transforms result', () async {
      final future = Future.value('hello');
      final length = await future.thenMap((s) => s.length);
      
      expect(length, 5);
    });

    test('delay waits after completion', () async {
      final start = DateTime.now();
      final future = Future.value('result');
      final result = await future.delay(Duration(milliseconds: 100));
      final elapsed = DateTime.now().difference(start);
      
      expect(result, 'result');
      expect(elapsed.inMilliseconds >= 100, true);
    });

    test('withLoading tracks loading state', () async {
      final loading = ValueNotifier(false);
      expect(loading.value, false);
      
      final future = Future.delayed(
        Duration(milliseconds: 50),
        () => 'result',
      ).withLoading(loading);
      
      expect(loading.value, true);
      final result = await future;
      expect(result, 'result');
      expect(loading.value, false);
    });
  });
}
