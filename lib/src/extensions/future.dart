part of './../extensions.dart';

extension FutureExtensions<T> on Future<T> {
  /// Adds a timeout to the future.
  ///
  /// Example:
  /// ```dart
  /// final result = await fetchData().timeout(
  ///   Duration(seconds: 5),
  ///   onTimeout: () => defaultValue,
  /// );
  /// ```
  Future<T> timeout(Duration duration, {T Function()? onTimeout}) {
    return Future.any([
      this,
      Future.delayed(duration).then((_) {
        if (onTimeout != null) {
          return onTimeout();
        }
        throw TimeoutException('Operation timed out', duration);
      }),
    ]);
  }

  /// Retries the future when the error matches the test condition.
  ///
  /// Example:
  /// ```dart
  /// await fetchData().retryWhen(
  ///   (error) => error is NetworkException,
  ///   maxAttempts: 3,
  /// );
  /// ```
  Future<T> retryWhen(bool Function(Object) test, {int maxAttempts = 3}) async {
    int attempts = 0;
    while (true) {
      try {
        return await this;
      } catch (e) {
        attempts++;
        if (!test(e) || attempts >= maxAttempts) {
          rethrow;
        }
        // Wait before retrying (exponential backoff)
        await Future.delayed(Duration(milliseconds: 100 * attempts));
      }
    }
  }

  /// Catches errors and returns a default value.
  ///
  /// Example:
  /// ```dart
  /// final result = await fetchData().catchError((error) => defaultValue);
  /// ```
  Future<T> catchError(T Function(Object) onError) {
    return then((value) => value, onError: onError);
  }

  /// Maps the result of the future to a new value.
  ///
  /// Example:
  /// ```dart
  /// final length = await fetchString().thenMap((s) => s.length);
  /// ```
  Future<R> thenMap<R>(R Function(T) mapper) {
    return then(mapper);
  }

  /// Delays the completion of this future.
  ///
  /// Example:
  /// ```dart
  /// final result = await fetchData().delay(Duration(seconds: 1));
  /// ```
  Future<T> delay(Duration duration) async {
    final result = await this;
    await Future.delayed(duration);
    return result;
  }

  /// Tracks loading state using a ValueNotifier.
  ///
  /// Example:
  /// ```dart
  /// final loading = ValueNotifier(false);
  /// final result = await fetchData().withLoading(loading);
  /// ```
  Future<T> withLoading(ValueNotifier<bool> loading) async {
    loading.value = true;
    try {
      return await this;
    } finally {
      loading.value = false;
    }
  }
}

/// ValueNotifier for tracking boolean state
class ValueNotifier<T> {
  T value;

  ValueNotifier(this.value);
}
