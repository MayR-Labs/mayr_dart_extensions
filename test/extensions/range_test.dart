import 'package:test/test.dart';
import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';

void main() {
  group('IntRange', () {
    test('to creates inclusive range', () {
      expect(1.to(5), [1, 2, 3, 4, 5]);
      expect(5.to(1), [5, 4, 3, 2, 1]);
    });

    test('to with step', () {
      expect(1.to(10, step: 2), [1, 3, 5, 7, 9]);
      expect(0.to(10, step: 3), [0, 3, 6, 9]);
    });

    test('until creates exclusive range', () {
      expect(1.until(5), [1, 2, 3, 4]);
      expect(5.until(1), [5, 4, 3, 2]);
    });

    test('until with step', () {
      expect(0.until(10, step: 2), [0, 2, 4, 6, 8]);
    });

    test('inRange checks if in range inclusive', () {
      expect(5.inRange(1, 10), true);
      expect(1.inRange(1, 10), true);
      expect(10.inRange(1, 10), true);
      expect(0.inRange(1, 10), false);
      expect(11.inRange(1, 10), false);
    });

    test('inRange checks if in range exclusive', () {
      expect(5.inRange(1, 10, inclusive: false), true);
      expect(1.inRange(1, 10, inclusive: false), false);
      expect(10.inRange(1, 10, inclusive: false), false);
    });
  });

  group('DoubleRange', () {
    test('to creates inclusive range', () {
      expect(1.0.to(5.0), [1.0, 2.0, 3.0, 4.0, 5.0]);
    });

    test('to with step', () {
      final result = 0.0.to(1.0, step: 0.25);
      expect(result.length, 5);
      expect(result[0], 0.0);
      expect(result[1], 0.25);
      expect(result[2], 0.5);
      expect(result[3], 0.75);
      expect(result[4], 1.0);
    });

    test('inRange checks if in range', () {
      expect(5.5.inRange(1.0, 10.0), true);
      expect(1.0.inRange(1.0, 10.0), true);
      expect(10.0.inRange(1.0, 10.0), true);
      expect(0.5.inRange(1.0, 10.0), false);
      expect(10.5.inRange(1.0, 10.0), false);
    });
  });
}
