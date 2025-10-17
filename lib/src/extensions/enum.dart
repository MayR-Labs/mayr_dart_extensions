part of './../extensions.dart';

extension EnumExtensions<T extends Enum> on T {
  /// Converts enum value to a human-readable display name.
  ///
  /// Example:
  /// ```dart
  /// enum Status { active, inProgress, completed }
  /// Status.inProgress.displayName; // 'In Progress'
  /// ```
  String get displayName {
    final name = this.name;
    // Split camelCase and add spaces
    final result = name.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (m) => '${m[1]} ${m[2]}',
    );
    // Capitalize first letter of each word
    return result.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  /// Converts enum to JSON string representation.
  ///
  /// Example:
  /// ```dart
  /// enum Status { active }
  /// Status.active.toJson(); // 'active'
  /// ```
  String toJson() => name;
}

extension EnumListExtensions<T extends Enum> on List<T> {
  /// Finds an enum value by its string name.
  ///
  /// Example:
  /// ```dart
  /// enum Status { active, inactive }
  /// Status.values.fromString('active'); // Status.active
  /// Status.values.fromString('unknown'); // null
  /// ```
  T? fromString(String name) {
    try {
      return firstWhere((e) => e.name == name);
    } catch (_) {
      return null;
    }
  }
}
