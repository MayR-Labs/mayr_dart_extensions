# Contributing to mayr_dart_extensions

First off, thank you for considering contributing to mayr_dart_extensions! It's people like you that make this package a great tool for the Dart community.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Testing Guidelines](#testing-guidelines)

## Code of Conduct

This project and everyone participating in it is governed by respect and professionalism. By participating, you are expected to uphold this standard. Please be respectful and constructive in all interactions.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues as you might find that the issue has already been reported. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples** - Include code snippets that demonstrate the issue
- **Describe the behavior you observed** and what you expected to see
- **Include Dart version** and other relevant environment details

### Suggesting Enhancements

Enhancement suggestions are welcome! When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description** of the suggested enhancement
- **Include code examples** showing how the enhancement would be used
- **Explain why this enhancement would be useful** to most users

### Adding New Extensions

We're always looking for useful extensions! When adding new extensions:

1. **Ensure it's pure Dart** - No Flutter dependencies
2. **Make it generally useful** - The extension should benefit a wide range of use cases
3. **Follow existing patterns** - Look at how similar extensions are implemented
4. **Add comprehensive documentation** - Include dartdoc comments with examples
5. **Write tests** - All new extensions must have test coverage

## Development Setup

### Prerequisites

- Dart SDK 3.7.0 or higher
- Git

### Setting Up Your Development Environment

1. **Fork the repository** on GitHub

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/mayr_dart_extensions.git
   cd mayr_dart_extensions
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/MayR-Labs/mayr_dart_extensions.git
   ```

4. **Install dependencies**
   ```bash
   dart pub get
   ```

5. **Verify setup**
   ```bash
   dart test
   dart analyze
   ```

## Pull Request Process

1. **Create a new branch** for your feature or bugfix
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Make your changes**
   - Write clear, concise code
   - Add or update tests as needed
   - Update documentation

3. **Run tests and linting**
   ```bash
   dart test
   dart format .
   dart analyze --fatal-warnings .
   ```

4. **Commit your changes**
   - Use clear, descriptive commit messages
   - Follow conventional commits format:
     - `feat: add new string extension for palindrome checking`
     - `fix: correct datetime age calculation`
     - `docs: update README with new examples`
     - `test: add tests for map extensions`

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Use a clear, descriptive title
   - Reference any related issues
   - Describe your changes in detail
   - Include examples of how to use new features

7. **Address review feedback**
   - Be responsive to comments and suggestions
   - Make requested changes promptly
   - Push updates to the same branch

## Style Guidelines

### Dart Code Style

- **Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)**
- **Use `dart format`** to automatically format your code
- **Keep functions focused** - Each function should do one thing well
- **Avoid overly complex expressions** - Break down complex logic into smaller parts
- **Use meaningful names** - Variable and function names should be descriptive

### Documentation Style

- **Use dartdoc comments** for all public APIs
- **Include examples** in documentation
- **Be concise but complete** - Explain what, why, and how
- **Use proper grammar** and punctuation

Example:
```dart
/// Converts the string to camelCase.
///
/// Removes special characters, splits on spaces/underscores/hyphens,
/// and capitalizes each word except the first.
///
/// Example:
/// ```dart
/// 'hello world'.camelCase; // 'helloWorld'
/// 'user_name'.camelCase; // 'userName'
/// ```
String get camelCase => ...
```

### File Organization

- **One extension per logical grouping** - Keep related extensions together
- **Use part files** for extensions under `lib/src/extensions/`
- **Export publicly** from `lib/mayr_dart_extensions.dart`

## Testing Guidelines

### Writing Tests

- **Test all public APIs** - Every extension should have tests
- **Test edge cases** - Empty strings, null values, boundary conditions
- **Use descriptive test names** - Test names should describe what is being tested
- **Organize tests by extension type** - Mirror the structure of the lib/ directory

Example:
```dart
import 'package:test/test.dart';
import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';

void main() {
  group('StringCasingExtensions', () {
    test('camelCase converts string correctly', () {
      expect('hello world'.camelCase, equals('helloWorld'));
      expect('user_name'.camelCase, equals('userName'));
      expect(''.camelCase, equals(''));
    });

    test('camelCase handles edge cases', () {
      expect('a'.camelCase, equals('a'));
      expect('HELLO WORLD'.camelCase, equals('helloWorld'));
    });
  });
}
```

### Running Tests

```bash
# Run all tests
dart test

# Run specific test file
dart test test/extensions/string_test.dart

# Run with coverage
dart test --coverage=coverage
dart pub global activate coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib
```

## Questions?

If you have questions about contributing, feel free to:

- Open an issue with the `question` label
- Reach out to the maintainers

## Recognition

Contributors will be recognized in the project. Thank you for making mayr_dart_extensions better!

---

**Happy coding! 🚀**
