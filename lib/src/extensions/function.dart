part of './../extensions.dart';

extension FunctionExtensions<T, R> on R Function(T) {
  /// Composes this function with another function.
  ///
  /// Returns a new function that applies [other] first, then applies this function.
  ///
  /// Example:
  /// ```dart
  /// final addOne = (int x) => x + 1;
  /// final double = (int x) => x * 2;
  /// final addOneThenDouble = double.compose(addOne);
  /// addOneThenDouble(5); // 12 (5 + 1 = 6, 6 * 2 = 12)
  /// ```
  R Function(S) compose<S>(T Function(S) other) => (x) => this(other(x));

  /// Creates a memoized version of this function that caches results.
  ///
  /// Example:
  /// ```dart
  /// int callCount = 0;
  /// final expensive = (int x) {
  ///   callCount++;
  ///   return x * x;
  /// };
  /// final memoized = expensive.memoize();
  /// memoized(5); // callCount = 1
  /// memoized(5); // callCount = 1 (cached)
  /// ```
  R Function(T) memoize() {
    final cache = <T, R>{};
    return (T arg) => cache.putIfAbsent(arg, () => this(arg));
  }

  /// Creates a debounced version of this function.
  ///
  /// The function will only be called after [duration] has elapsed
  /// since the last invocation attempt.
  ///
  /// Example:
  /// ```dart
  /// final search = (String query) => print('Searching: $query');
  /// final debouncedSearch = search.debounce(Duration(milliseconds: 300));
  /// debouncedSearch('a'); // Will only execute after 300ms of no more calls
  /// ```
  R Function(T) debounce(Duration duration) {
    Timer? timer;
    return (T arg) {
      timer?.cancel();
      timer = Timer(duration, () => this(arg));
      return this(arg); // Return immediate result
    };
  }

  /// Creates a throttled version of this function.
  ///
  /// The function will be called at most once per [duration].
  ///
  /// Example:
  /// ```dart
  /// final update = (String data) => print('Updating: $data');
  /// final throttledUpdate = update.throttle(Duration(seconds: 1));
  /// throttledUpdate('a'); // Executes immediately
  /// throttledUpdate('b'); // Ignored if within 1 second
  /// ```
  R Function(T) throttle(Duration duration) {
    DateTime? lastCall;
    return (T arg) {
      final now = DateTime.now();
      if (lastCall == null || now.difference(lastCall!) >= duration) {
        lastCall = now;
        return this(arg);
      }
      return this(arg); // Return result even if throttled
    };
  }

  /// Calls this function with the given argument after a delay.
  ///
  /// Example:
  /// ```dart
  /// final greet = (String name) => print('Hello, $name');
  /// await greet.delayed(Duration(seconds: 1), 'John');
  /// ```
  Future<R> delayed(Duration duration, T arg) async {
    await Future.delayed(duration);
    return this(arg);
  }
}
