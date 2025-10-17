part of './../extensions.dart';

extension StreamExtensions<T> on Stream<T> {
  /// Debounces the stream by the specified duration.
  ///
  /// Only emits an item when a specified duration has passed without emitting another item.
  ///
  /// Example:
  /// ```dart
  /// stream.debounceTime(Duration(milliseconds: 300));
  /// ```
  Stream<T> debounceTime(Duration duration) {
    Timer? timer;
    late StreamController<T> controller;

    controller = StreamController<T>(
      onListen: () {
        listen(
          (data) {
            timer?.cancel();
            timer = Timer(duration, () {
              controller.add(data);
            });
          },
          onError: controller.addError,
          onDone: () {
            timer?.cancel();
            controller.close();
          },
        );
      },
      onCancel: () => timer?.cancel(),
    );

    return controller.stream;
  }

  /// Throttles the stream by the specified duration.
  ///
  /// Emits at most one item per duration.
  ///
  /// Example:
  /// ```dart
  /// stream.throttleTime(Duration(seconds: 1));
  /// ```
  Stream<T> throttleTime(Duration duration) {
    DateTime? lastEmit;
    late StreamController<T> controller;

    controller = StreamController<T>(
      onListen: () {
        listen(
          (data) {
            final now = DateTime.now();
            if (lastEmit == null || now.difference(lastEmit!) >= duration) {
              lastEmit = now;
              controller.add(data);
            }
          },
          onError: controller.addError,
          onDone: controller.close,
        );
      },
    );

    return controller.stream;
  }

  /// Emits values only when they are different from the previous value.
  ///
  /// Example:
  /// ```dart
  /// stream.distinctUntilChanged(); // 1, 2, 1, 3 -> 1, 2, 1, 3
  /// ```
  Stream<T> distinctUntilChanged() {
    T? previous;
    bool isFirst = true;

    return where((data) {
      if (isFirst) {
        isFirst = false;
        previous = data;
        return true;
      }
      if (data != previous) {
        previous = data;
        return true;
      }
      return false;
    });
  }

  /// Buffers items emitted during the specified time window.
  ///
  /// Example:
  /// ```dart
  /// stream.bufferTime(Duration(seconds: 1)); // [[items in 1s], [items in next 1s], ...]
  /// ```
  Stream<List<T>> bufferTime(Duration duration) {
    late StreamController<List<T>> controller;
    List<T> buffer = [];
    Timer? timer;

    void emitBuffer() {
      if (buffer.isNotEmpty) {
        controller.add(List.from(buffer));
        buffer.clear();
      }
    }

    controller = StreamController<List<T>>(
      onListen: () {
        timer = Timer.periodic(duration, (_) => emitBuffer());
        listen(
          (data) => buffer.add(data),
          onError: controller.addError,
          onDone: () {
            timer?.cancel();
            emitBuffer();
            controller.close();
          },
        );
      },
      onCancel: () => timer?.cancel(),
    );

    return controller.stream;
  }

  /// Retries the stream when an error matches the test condition.
  ///
  /// Example:
  /// ```dart
  /// stream.retryWhen((error) => error is NetworkException);
  /// ```
  Stream<T> retryWhen(bool Function(Object) test) {
    late StreamController<T> controller;

    void startListening() {
      listen(
        controller.add,
        onError: (error) {
          if (test(error)) {
            // Retry by resubscribing
            startListening();
          } else {
            controller.addError(error);
          }
        },
        onDone: controller.close,
      );
    }

    controller = StreamController<T>(onListen: startListening);

    return controller.stream;
  }

  /// Returns the first element that satisfies the test, or null if none found.
  ///
  /// Example:
  /// ```dart
  /// final result = await stream.firstWhereOrNull((x) => x > 5);
  /// ```
  Future<T?> firstWhereOrNull(bool Function(T) test) async {
    await for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
