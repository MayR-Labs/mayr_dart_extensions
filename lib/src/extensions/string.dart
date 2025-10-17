part of './../extensions.dart';

extension MayrPrettyStringExtensions on String {
  String prettyJson() =>
      const JsonEncoder.withIndent('  ').convert(jsonDecode(this));

  String prettyXml() => XmlDocument.parse(this).toXmlString(pretty: true);

  String prettyYaml() =>
      const JsonEncoder.withIndent('  ').convert(loadYaml(this));
}

extension MayrStringCasingExtensions on String {
  /// Converts to camelCase
  String get camelCase =>
      _cleanWords.first.toLowerCase() +
      _cleanWords.skip(1).map((w) => w.capitalised).join('');

  /// Capitalises only the first letter
  String get capitalised =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  /// Converts to kebab-case
  String get kebabCase => _cleanWords.join('-').toLowerCase();

  /// Converts to PascalCase
  String get pascalCase => _cleanWords.map((w) => w.capitalised).join('');

  /// Converts to snake_case
  String get snakeCase => _cleanWords.join('_').toLowerCase();

  /// Converts to Title Case
  String get titleCase =>
      split(RegExp(r'[\s_\-]+')).map((word) => word.capitalised).join(' ');

  List<String> get _cleanWords {
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
        .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (m) => '${m[1]} ${m[2]}',
        ) // camel case splitter
        .split(RegExp(r'[\s\-_]+')) // split by spaces, underscores, hyphens
        .where((w) => w.trim().isNotEmpty)
        .toList();
  }
}

extension MayrStringCompareExtensions on String {
  bool get isCamelCase => camelCase == this;

  bool get isCapitalised => capitalised == this;

  bool get isKebabCase => kebabCase == this;

  bool get isLowerCase => this == toLowerCase();

  bool get isNum => num.tryParse(this) is num;

  bool get isPascalCase => pascalCase == this;

  bool get isSnakeCase => snakeCase == this;

  bool get isTitleCase => titleCase == this;

  bool get isUpperCase => this == toUpperCase();
}

extension MayrStringExtensions on String {
  /// Checks if the string matches the given regex
  bool matchesRegExp(String regex) => regex.toRegExp().hasMatch(this);

  /// Attempts to convert the string to a boolean.
  ///
  /// #### `'true'`, `'yes'`, `'y'` and `1` equates to `true`
  /// #### `'false'`, `'no'`, `'n'` and `0` equates to `false`
  /// All other strings throw an `UnsupportedError` exception
  /// unless `fallback` is provided, in which case it would be returned
  bool toBool([bool? fallback]) {
    if (["true", "yes", "y", "1"].contains(toLowerCase())) return true;

    if (["false", "no", "n", "0"].contains(toLowerCase())) return false;

    if (fallback != null) return fallback;

    throw UnsupportedError("Cannot convert $this to a boolean");
  }

  /// Attempt to convert a [String] to a [DateTime].
  DateTime? toDateTime() => DateTime.tryParse(this);

  /// Converts a string to a [RegExp]
  RegExp toRegExp() => RegExp(this);

  /// Attempt to convert a string to a Uri.
  ///
  /// `Null` is returned when the string cannot be parsed
  Uri? toUri() => Uri.tryParse(this);

  /// Limit the string to a maximum length with optional overflow indicator.
  ///
  /// Returns the full string if it's within [maxLength],
  /// otherwise truncates and appends [overflow] (default: "...").
  ///
  /// Example:
  /// ```dart
  /// 'Hello World'.limit(5); // 'Hello...'
  /// 'Hi'.limit(5); // 'Hi'
  /// ```
  String limit(int maxLength, [String overflow = "..."]) =>
      length <= maxLength ? this : substring(0, maxLength) + overflow;

  /// Mask the string by replacing characters with a mask character.
  ///
  /// The [start] and [end] parameters define how many characters
  /// to keep visible at the beginning and end of the string.
  /// [maskChar] is the character used for masking (default: '*').
  /// [maskLength] can be used to set a fixed mask length.
  ///
  /// Example:
  /// ```dart
  /// 'secret@email.com'.mask(); // 'se**************om'
  /// 'secret@email.com'.mask(maskLength: 5); // 'se*****om'
  /// ```
  String mask({
    int start = 2,
    int end = 2,
    String maskChar = '*',
    int? maskLength,
  }) {
    if (length <= start + end) return this;

    maskLength ??= length - start - end;

    String masked = List.filled(maskLength, maskChar).join();

    return [substring(0, start), masked, substring(length - end)].join();
  }

  /// Reverses the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.reverse(); // 'olleh'
  /// ```
  String reverse() => split('').reversed.join('');

  /// Checks if the string is empty or contains only whitespace.
  bool get isBlank => trim().isEmpty;

  /// Checks if the string is not empty and contains non-whitespace characters.
  bool get isNotBlank => !isBlank;

  /// Removes all whitespace from the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.removeWhitespace(); // 'helloworld'
  /// ```
  String removeWhitespace() => replaceAll(RegExp(r'\s+'), '');

  /// Counts the number of occurrences of a substring within the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.countOccurrences('l'); // 3
  /// 'hello world'.countOccurrences('o'); // 2
  /// ```
  int countOccurrences(String substring) {
    if (substring.isEmpty) return 0;
    int count = 0;
    int index = 0;
    while ((index = indexOf(substring, index)) != -1) {
      count++;
      index += substring.length;
    }
    return count;
  }

  /// Truncates the string to a specified length and adds an ellipsis if needed.
  ///
  /// This is similar to [limit] but ensures word boundaries are respected
  /// when possible.
  ///
  /// Example:
  /// ```dart
  /// 'The quick brown fox'.truncate(10); // 'The quick...'
  /// ```
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;

    final truncated = substring(0, maxLength);
    final lastSpace = truncated.lastIndexOf(' ');

    // If we found a space and it's not too far from the end, break there
    if (lastSpace > maxLength * 0.7) {
      return '${truncated.substring(0, lastSpace)}$ellipsis';
    }

    return '$truncated$ellipsis';
  }

  /// Wraps the string with the specified prefix and suffix.
  ///
  /// Example:
  /// ```dart
  /// 'text'.wrap('"'); // '"text"'
  /// 'text'.wrap('[', ']'); // '[text]'
  /// ```
  String wrap(String prefix, [String? suffix]) {
    suffix ??= prefix;
    return '$prefix$this$suffix';
  }

  /// Removes the specified prefix from the string if it exists.
  ///
  /// Example:
  /// ```dart
  /// 'Hello World'.removePrefix('Hello '); // 'World'
  /// ```
  String removePrefix(String prefix) {
    if (startsWith(prefix)) {
      return substring(prefix.length);
    }
    return this;
  }

  /// Removes the specified suffix from the string if it exists.
  ///
  /// Example:
  /// ```dart
  /// 'Hello World'.removeSuffix(' World'); // 'Hello'
  /// ```
  String removeSuffix(String suffix) {
    if (endsWith(suffix)) {
      return substring(0, length - suffix.length);
    }
    return this;
  }
}

extension MayrStringPatternComparisonExtensions on String {
  bool get isAlphabetOnly => matchesRegExp(r'^[a-zA-Z]+$');

  bool get isEmail => matchesRegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  bool get isHexColor => matchesRegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

  bool get isIPAddress => matchesRegExp(
    r'^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$',
  );

  bool get isNumericOnly => matchesRegExp(r'^\d+$');

  bool get isSlug => matchesRegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$');

  bool get isUlid => toUpperCase().matchesRegExp(r'^[0-9A-HJKMNP-TV-Z]{26}$');

  bool get isUpperCase => this == toUpperCase();

  bool get isURL => matchesRegExp(
    r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$",
  );

  bool get isUuid => matchesRegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  );
}

extension StringTemplateExtensions on String {
  /// Formats the string using a map of named values.
  ///
  /// Example:
  /// ```dart
  /// 'Hello {name}, you are {age} years old'.format({'name': 'John', 'age': 30});
  /// // 'Hello John, you are 30 years old'
  /// ```
  String format(Map<String, dynamic> values) {
    String result = this;
    values.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    return result;
  }

  /// Formats the string using a list of positional values.
  ///
  /// Example:
  /// ```dart
  /// 'Hello {0}, you are {1} years old'.formatList(['John', 30]);
  /// // 'Hello John, you are 30 years old'
  /// ```
  String formatList(List<dynamic> values) {
    String result = this;
    for (int i = 0; i < values.length; i++) {
      result = result.replaceAll('{$i}', values[i].toString());
    }
    return result;
  }

  /// Interpolates the string using a resolver function.
  ///
  /// Example:
  /// ```dart
  /// 'Hello {name}'.interpolate((key) => key == 'name' ? 'John' : '');
  /// // 'Hello John'
  /// ```
  String interpolate(dynamic Function(String) resolver) {
    return replaceAllMapped(RegExp(r'\{([^}]+)\}'), (match) {
      final key = match.group(1)!;
      return resolver(key).toString();
    });
  }

  /// Repeats the string [count] times with optional separator.
  ///
  /// Example:
  /// ```dart
  /// 'abc'.repeat(3); // 'abcabcabc'
  /// 'abc'.repeat(3, separator: '-'); // 'abc-abc-abc'
  /// ```
  String repeat(int count, {String separator = ''}) {
    if (count <= 0) return '';
    return List.filled(count, this).join(separator);
  }
}

extension Base64Extensions on String {
  /// Encodes the string to Base64.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.toBase64(); // 'aGVsbG8='
  /// ```
  String toBase64() {
    return base64.encode(utf8.encode(this));
  }

  /// Decodes the Base64 string.
  ///
  /// Example:
  /// ```dart
  /// 'aGVsbG8='.fromBase64(); // 'hello'
  /// ```
  String fromBase64() {
    return utf8.decode(base64.decode(this));
  }

  /// Checks if the string is valid Base64.
  ///
  /// Example:
  /// ```dart
  /// 'aGVsbG8='.isBase64; // true
  /// 'not base64!'.isBase64; // false
  /// ```
  bool get isBase64 {
    try {
      base64.decode(this);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Converts Base64 string to bytes.
  ///
  /// Example:
  /// ```dart
  /// 'aGVsbG8='.toBase64Bytes(); // [104, 101, 108, 108, 111]
  /// ```
  List<int> toBase64Bytes() {
    return base64.decode(this);
  }
}

extension ValidationExtensions on String {
  /// Checks if the password is strong.
  ///
  /// Strong: Min 8 chars, uppercase, lowercase, number, special character.
  ///
  /// Example:
  /// ```dart
  /// 'MyP@ssw0rd'.isStrongPassword; // true
  /// 'weak'.isStrongPassword; // false
  /// ```
  bool get isStrongPassword {
    if (length < 8) return false;
    if (!matchesRegExp(r'[A-Z]')) return false; // uppercase
    if (!matchesRegExp(r'[a-z]')) return false; // lowercase
    if (!matchesRegExp(r'[0-9]')) return false; // number
    if (!matchesRegExp(r'[!@#$%^&*(),.?":{}|<>]')) return false; // special
    return true;
  }

  /// Checks if the password is weak.
  ///
  /// Example:
  /// ```dart
  /// 'weak'.isWeakPassword; // true
  /// ```
  bool get isWeakPassword => !isStrongPassword;

  /// Returns password strength as a value between 0.0 and 1.0.
  ///
  /// Example:
  /// ```dart
  /// 'MyP@ssw0rd'.passwordStrength; // ~0.8
  /// 'weak'.passwordStrength; // ~0.2
  /// ```
  double get passwordStrength {
    double strength = 0.0;
    if (length >= 8) strength += 0.2;
    if (length >= 12) strength += 0.1;
    if (matchesRegExp(r'[A-Z]')) strength += 0.2;
    if (matchesRegExp(r'[a-z]')) strength += 0.2;
    if (matchesRegExp(r'[0-9]')) strength += 0.15;
    if (matchesRegExp(r'[!@#$%^&*(),.?":{}|<>]')) strength += 0.15;
    return strength.clamp(0.0, 1.0);
  }

  /// Checks if the string is a valid credit card number (basic Luhn check).
  ///
  /// Example:
  /// ```dart
  /// '4532015112830366'.isCreditCard; // true
  /// ```
  bool get isCreditCard {
    final cleaned = replaceAll(RegExp(r'\s+'), '');
    if (!cleaned.matchesRegExp(r'^\d{13,19}$')) return false;

    int sum = 0;
    bool alternate = false;
    for (int i = cleaned.length - 1; i >= 0; i--) {
      int digit = int.parse(cleaned[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  /// Checks if the string is a valid postal code (basic patterns).
  ///
  /// Example:
  /// ```dart
  /// '12345'.isPostalCode; // true (US)
  /// 'SW1A 1AA'.isPostalCode; // true (UK)
  /// ```
  bool get isPostalCode {
    // US: 12345 or 12345-6789
    if (matchesRegExp(r'^\d{5}(-\d{4})?$')) return true;
    // UK: SW1A 1AA
    if (matchesRegExp(r'^[A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}$')) return true;
    // Canada: A1A 1A1
    if (matchesRegExp(r'^[A-Z]\d[A-Z] ?\d[A-Z]\d$')) return true;
    return false;
  }

  /// Checks if the string is a valid phone number (basic pattern).
  ///
  /// Example:
  /// ```dart
  /// '+1-555-123-4567'.isPhoneNumber; // true
  /// '(555) 123-4567'.isPhoneNumber; // true
  /// ```
  bool get isPhoneNumber {
    final cleaned = replaceAll(RegExp(r'[\s\-\(\)]'), '');
    return cleaned.matchesRegExp(r'^\+?\d{10,15}$');
  }

  /// Checks if the string is a valid MAC address.
  ///
  /// Example:
  /// ```dart
  /// '00:1B:63:84:45:E6'.isMACAddress; // true
  /// '00-1B-63-84-45-E6'.isMACAddress; // true
  /// ```
  bool get isMACAddress {
    return matchesRegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
  }
}
