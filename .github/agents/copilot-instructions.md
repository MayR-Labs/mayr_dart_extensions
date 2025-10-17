# Copilot Instructions for mayr_dart_extensions

## Project Overview

**mayr_dart_extensions** is a pure Dart package providing a comprehensive set of handy extension methods to make Dart code cleaner, shorter, and more expressive.

- **Organization**: MayR Labs (https://mayrlabs.com)
- **Repository**: https://github.com/MayR-Labs/mayr_dart_extensions
- **Package Type**: Pure Dart (not Flutter-specific)
- **License**: MIT

## Important Guidelines

### Language & Framework
- This is a **pure Dart package** - do NOT add Flutter dependencies
- All extensions must work with Dart SDK only
- For Flutter-specific extensions, refer users to the separate `mayr_flutter_extensions` package

### Code Quality
- Follow Dart style guide and conventions
- Use dartdoc comments for all public APIs
- Include code examples in documentation
- Ensure all code passes `dart analyze` without warnings
- Format code with `dart format`

### Testing
- Write tests for all new features
- Maintain high test coverage
- Tests should run with `dart test` (not `flutter test`)
- Follow existing test patterns in the `test/` directory

### Dependencies
- Minimize external dependencies
- Only add dependencies that are pure Dart packages
- Avoid packages that require Flutter
- Keep `intl`, `xml`, `yaml`, and `get_time_ago` for existing functionality

### Pull Requests
- Keep changes focused and atomic
- Update CHANGELOG.md following Keep a Changelog format
- Update README.md if adding new features
- Ensure all CI checks pass before merging

### Documentation
- Update README.md for user-facing changes
- Keep examples simple and clear
- Organize extensions by type (String, Number, DateTime, etc.)
- Include usage examples for complex features

## Common Tasks

### Adding a New Extension
1. Create a new file in `lib/src/extensions/` or add to existing file
2. Use `part of './../extensions.dart';` directive
3. Export in `lib/src/extensions.dart`
4. Add comprehensive dartdoc comments
5. Create tests in `test/extensions/`
6. Update README.md with examples
7. Update CHANGELOG.md

### Running Tests
```bash
dart pub get
dart test
```

### Linting and Formatting
```bash
dart format .
dart analyze --fatal-warnings .
```

### Publishing
- Update version in `pubspec.yaml` following semver
- Update CHANGELOG.md with changes
- Ensure all tests pass
- Run `dart pub publish --dry-run`

## Project Structure
```
lib/
  ├── mayr_extensions.dart          # Main export file
  └── src/
      ├── extensions.dart            # Extensions aggregator
      ├── extensions/                # Individual extension files
      │   ├── bool.dart
      │   ├── date_time.dart
      │   ├── duration.dart
      │   ├── dynamic.dart
      │   ├── humanize.dart
      │   ├── list.dart
      │   ├── map.dart
      │   ├── number.dart
      │   ├── object.dart
      │   ├── set.dart
      │   └── string.dart
      └── tools/
          └── mayr_date_time_formats.dart

test/
  ├── extensions/                    # Extension tests
  └── mayr_extensions_test.dart     # Main test file

example/
  └── example.dart                   # Usage examples
```

## Contact
For questions or issues, please open an issue on GitHub: https://github.com/MayR-Labs/mayr_dart_extensions/issues
