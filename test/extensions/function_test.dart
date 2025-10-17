import 'package:test/test.dart';
import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';

void main() {
  group('FunctionExtensions', () {
    test('compose chains functions correctly', () {
      int addOne(int x) => x + 1;
      int double(int x) => x * 2;
      final addOneThenDouble = double.compose(addOne);

      expect(addOneThenDouble(5), 12); // (5 + 1) * 2 = 12
    });

    test('memoize caches results', () {
      int callCount = 0;
      int expensive(int x) {
        callCount++;
        return x * x;
      }

      final memoized = expensive.memoize();

      expect(memoized(5), 25);
      expect(callCount, 1);
      expect(memoized(5), 25); // Should use cache
      expect(callCount, 1); // Not called again
      expect(memoized(3), 9);
      expect(callCount, 2); // New value, so called
    });

    test('delayed executes after duration', () async {
      String greet(String name) => 'Hello, $name';
      final start = DateTime.now();
      final result = await greet.delayed(Duration(milliseconds: 100), 'John');
      final elapsed = DateTime.now().difference(start);

      expect(result, 'Hello, John');
      expect(elapsed.inMilliseconds >= 100, true);
    });
  });
}
