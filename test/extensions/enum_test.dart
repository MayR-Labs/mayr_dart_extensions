import 'package:test/test.dart';
import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';

enum TestStatus { active, inProgress, completed, onHold }

void main() {
  group('EnumExtensions', () {
    test('displayName converts to readable string', () {
      expect(TestStatus.active.displayName, 'Active');
      expect(TestStatus.inProgress.displayName, 'In Progress');
      expect(TestStatus.completed.displayName, 'Completed');
      expect(TestStatus.onHold.displayName, 'On Hold');
    });

    test('toJson returns enum name', () {
      expect(TestStatus.active.toJson(), 'active');
      expect(TestStatus.inProgress.toJson(), 'inProgress');
    });

    test('fromString finds enum by name', () {
      expect(TestStatus.values.fromString('active'), TestStatus.active);
      expect(TestStatus.values.fromString('inProgress'), TestStatus.inProgress);
      expect(TestStatus.values.fromString('unknown'), null);
    });
  });
}
