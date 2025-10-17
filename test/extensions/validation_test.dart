import 'package:test/test.dart';
import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';

void main() {
  group('StringTemplateExtensions', () {
    test('format replaces named placeholders', () {
      final result = 'Hello {name}, you are {age} years old'.format({
        'name': 'John',
        'age': 30,
      });

      expect(result, 'Hello John, you are 30 years old');
    });

    test('formatList replaces positional placeholders', () {
      final result = 'Hello {0}, you are {1} years old'.formatList([
        'John',
        30,
      ]);

      expect(result, 'Hello John, you are 30 years old');
    });

    test('interpolate uses resolver function', () {
      final result = 'Hello {name}, {greeting}'.interpolate((key) {
        if (key == 'name') return 'John';
        if (key == 'greeting') return 'welcome!';
        return '';
      });

      expect(result, 'Hello John, welcome!');
    });

    test('repeat repeats string', () {
      expect('abc'.repeat(3), 'abcabcabc');
      expect('x'.repeat(5), 'xxxxx');
      expect('abc'.repeat(0), '');
    });

    test('repeat with separator', () {
      expect('abc'.repeat(3, separator: '-'), 'abc-abc-abc');
      expect('x'.repeat(3, separator: ','), 'x,x,x');
    });
  });

  group('Base64Extensions', () {
    test('toBase64 encodes string', () {
      expect('hello'.toBase64(), 'aGVsbG8=');
      expect('world'.toBase64(), 'd29ybGQ=');
    });

    test('fromBase64 decodes string', () {
      expect('aGVsbG8='.fromBase64(), 'hello');
      expect('d29ybGQ='.fromBase64(), 'world');
    });

    test('isBase64 validates Base64', () {
      expect('aGVsbG8='.isBase64, true);
      expect('d29ybGQ='.isBase64, true);
      expect('not base64!'.isBase64, false);
      expect('invalid=='.isBase64, false);
    });

    test('toBase64Bytes converts to bytes', () {
      final bytes = 'aGVsbG8='.toBase64Bytes();
      expect(bytes, [104, 101, 108, 108, 111]); // 'hello' in ASCII
    });
  });

  group('Base64ListExtensions', () {
    test('toBase64String encodes bytes', () {
      final bytes = [72, 101, 108, 108, 111]; // 'Hello' in ASCII
      expect(bytes.toBase64String(), 'SGVsbG8=');
    });
  });

  group('ValidationExtensions', () {
    test('isStrongPassword validates strong passwords', () {
      expect('MyP@ssw0rd'.isStrongPassword, true);
      expect('Str0ng!Pass'.isStrongPassword, true);
      expect('weak'.isStrongPassword, false);
      expect('nospecial123'.isStrongPassword, false);
      expect('NOLOWER123!'.isStrongPassword, false);
      expect('noupper123!'.isStrongPassword, false);
      expect('NoNumber!'.isStrongPassword, false);
    });

    test('isWeakPassword is opposite of isStrongPassword', () {
      expect('weak'.isWeakPassword, true);
      expect('MyP@ssw0rd'.isWeakPassword, false);
    });

    test('passwordStrength returns strength score', () {
      expect('weak'.passwordStrength < 0.5, true);
      expect('MyP@ssw0rd'.passwordStrength >= 0.8, true);
      expect('VeryStr0ng!Pass'.passwordStrength >= 0.9, true);
    });

    test('isCreditCard validates credit card numbers', () {
      expect('4532015112830366'.isCreditCard, true); // Valid Visa test number
      expect('1234567890123456'.isCreditCard, false); // Invalid checksum
      expect('123'.isCreditCard, false); // Too short
    });

    test('isPostalCode validates postal codes', () {
      expect('12345'.isPostalCode, true); // US
      expect('12345-6789'.isPostalCode, true); // US extended
      expect('SW1A1AA'.isPostalCode, true); // UK
      expect('SW1A 1AA'.isPostalCode, true); // UK with space
      expect('invalid'.isPostalCode, false);
    });

    test('isPhoneNumber validates phone numbers', () {
      expect('+15551234567'.isPhoneNumber, true);
      expect('555-123-4567'.isPhoneNumber, true);
      expect('(555) 123-4567'.isPhoneNumber, true);
      expect('123'.isPhoneNumber, false);
    });

    test('isMACAddress validates MAC addresses', () {
      expect('00:1B:63:84:45:E6'.isMACAddress, true);
      expect('00-1B-63-84-45-E6'.isMACAddress, true);
      expect('00:1b:63:84:45:e6'.isMACAddress, true);
      expect('invalid'.isMACAddress, false);
      expect('00:1B:63:84:45'.isMACAddress, false); // Too short
    });
  });
}
