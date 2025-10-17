![License](https://img.shields.io/badge/license-MIT-blue.svg?label=Licence)
![Platform](https://img.shields.io/badge/Platform-Dart-blue.svg)

![Pub Version](https://img.shields.io/pub/v/mayr_dart_extensions?style=plastic&label=Version)
![Pub.dev Score](https://img.shields.io/pub/points/mayr_dart_extensions?label=Score&style=plastic)
![Pub Likes](https://img.shields.io/pub/likes/mayr_dart_extensions?label=Likes&style=plastic)
![Pub.dev Publisher](https://img.shields.io/pub/publisher/mayr_dart_extensions?label=Publisher&style=plastic)
![Downloads](https://img.shields.io/pub/dm/mayr_dart_extensions.svg?label=Downloads&style=plastic)

![Build Status](https://img.shields.io/github/actions/workflow/status/MayR-Labs/mayr_dart_extensions/ci.yaml?label=Build)
![Issues](https://img.shields.io/github/issues/MayR-Labs/mayr_dart_extensions.svg?label=Issues)
![Last Commit](https://img.shields.io/github/last-commit/MayR-Labs/mayr_dart_extensions.svg?label=Latest%20Commit)
![Contributors](https://img.shields.io/github/contributors/MayR-Labs/mayr_dart_extensions.svg?label=Contributors)


# mayr_dart_extensions

> A comprehensive collection of Dart extension methods to make your code cleaner, shorter, and more expressive.

**Pure Dart package** with zero Flutter dependencies. For Flutter-specific extensions, check out [mayr_flutter_extensions](https://pub.dev/packages/mayr_flutter_extensions).

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  mayr_dart_extensions: ^1.1.0
```

Or install via command line:

```bash
dart pub add mayr_dart_extensions
```

Then import:

```dart
import 'package:mayr_dart_extensions/mayr_dart_extensions.dart';
```

---

## ✨ Features at a Glance

| Extension Type | Key Features |
|----------------|--------------|
| **String** | Case conversion, validation, formatting, masking, templates, Base64 |
| **Number** | Clamping, random generation, formatting, ranges, duration conversion |
| **DateTime** | Time checks, manipulation, age calculation, formatting |
| **Duration** | Delays, readable strings, comparisons |
| **List/Iterable** | Safe access, transformations, aggregations, mutations |
| **Map** | Safe access, transformations, merging |
| **Set** | Toggle, intersections, subset operations |
| **Bool** | Conditional selection, conversions |
| **Function** | Composition, memoization, debounce, throttle |
| **Future** | Timeout, retry, error handling, loading state |
| **Stream** | Debounce, throttle, distinct, buffer, retry |
| **Uri** | Query params, domain/subdomain extraction, security checks |
| **Enum** | Display names, JSON conversion, string lookup |
| **Object** | Functional operations (`let`, `also`) |
| **Humanize** | Convert data to human-readable formats |

---

## 📚 Documentation

### String Extensions

<details>
<summary><b>Case Conversion</b></summary>

```dart
'hello world'.camelCase;      // 'helloWorld'
'hello world'.pascalCase;     // 'HelloWorld'
'hello world'.snakeCase;      // 'hello_world'
'hello world'.kebabCase;      // 'hello-world'
'hello world'.titleCase;      // 'Hello World'
'hello world'.capitalised;    // 'Hello world'
```
</details>

<details>
<summary><b>Validation & Pattern Matching</b></summary>

```dart
'test@example.com'.isEmail;           // true
'https://example.com'.isURL;          // true
'192.168.1.1'.isIPAddress;            // true
'#FF5733'.isHexColor;                 // true
'01ABZ23C4D5EF6GH7J8K9M'.isUlid;     // true
'550e8400-e29b-41d4-a716-446655440000'.isUuid;  // true
'hello-world-123'.isSlug;             // true
'12345'.isNumericOnly;                // true
'hello'.isAlphabetOnly;               // true
```
</details>

<details>
<summary><b>String Utilities</b></summary>

```dart
'hello'.reverse();                    // 'olleh'
'  '.isBlank;                         // true
'hello world'.removeWhitespace();     // 'helloworld'
'hello world'.countOccurrences('l');  // 3
'The quick brown fox'.truncate(10);   // 'The quick...'
'text'.wrap('"');                     // '"text"'
'08012345678'.mask();                 // '08*******78'
'long text'.limit(5);                 // 'long…'
```
</details>

<details>
<summary><b>Type Conversion</b></summary>

```dart
'true'.toBool;                        // true
'2025-01-15'.toDateTime();            // DateTime object
'[a-z]+'.toRegExp();                  // RegExp object
'https://example.com'.toUri();        // Uri object
```
</details>

<details>
<summary><b>Pretty Printing</b></summary>

```dart
'{"name":"John","age":30}'.prettyJson();
'<root><item>value</item></root>'.prettyXml();
'name: John\nage: 30'.prettyYaml();
```
</details>

<details>
<summary><b>String Templates</b></summary>

```dart
// Named placeholders
'Hello {name}, you are {age} years old'.format({'name': 'John', 'age': 30});
// 'Hello John, you are 30 years old'

// Positional placeholders
'Hello {0}, you are {1} years old'.formatList(['John', 30]);

// Interpolation with resolver
'Hello {name}'.interpolate((key) => key == 'name' ? 'John' : '');

// Repeat string
'abc'.repeat(3);                        // 'abcabcabc'
'abc'.repeat(3, separator: '-');        // 'abc-abc-abc'
```
</details>

<details>
<summary><b>Base64 Encoding</b></summary>

```dart
'hello'.toBase64();                     // 'aGVsbG8='
'aGVsbG8='.fromBase64();                // 'hello'
'aGVsbG8='.isBase64;                    // true
'aGVsbG8='.toBase64Bytes();             // [104, 101, 108, 108, 111]

// Encode bytes to Base64
[72, 101, 108, 108, 111].toBase64String();  // 'SGVsbG8='
```
</details>

<details>
<summary><b>Validation</b></summary>

```dart
// Password validation
'MyP@ssw0rd'.isStrongPassword;          // true (min 8 chars, upper, lower, number, special)
'weak'.isWeakPassword;                  // true
'MyP@ssw0rd'.passwordStrength;          // 0.8 (strength score 0.0-1.0)

// Credit card (Luhn check)
'4532015112830366'.isCreditCard;        // true

// Postal codes (US, UK, Canada)
'12345'.isPostalCode;                   // true
'SW1A 1AA'.isPostalCode;                // true

// Phone numbers
'+1-555-123-4567'.isPhoneNumber;        // true
'(555) 123-4567'.isPhoneNumber;         // true

// MAC addresses
'00:1B:63:84:45:E6'.isMACAddress;       // true
'00-1B-63-84-45-E6'.isMACAddress;       // true
```
</details>

---

### Number Extensions

<details>
<summary><b>Comparisons & Checks</b></summary>

```dart
5.isBetween(1, 10);          // true
5.isPositive;                // true
-5.isNegativeNumber;         // true
0.isZero;                    // true
4.isEvenNumber;              // true
5.isOddNumber;               // true
```
</details>

<details>
<summary><b>Clamping</b></summary>

```dart
5.clampMin(10);              // 10
20.clampMax(15);             // 15
```
</details>

<details>
<summary><b>Formatting</b></summary>

```dart
3.14159.toDecimalPlaces(2);                          // 3.14
1234.5.formatAsCurrency(locale: 'en_US', symbol: '\$');  // \$1,234.50
1234567.humanizeNumber();                            // '1.2M'
1024.humanizeFileSize();                             // '1.0 KB'
1.humanizeOrdinal();                                 // '1st'
21.humanizeOrdinal();                                // '21st'
3.humanizeCount('item');                             // '3 items'
```
</details>

<details>
<summary><b>Duration Conversion</b></summary>

```dart
2.days;                      // Duration(days: 2)
3.hours;                     // Duration(hours: 3)
30.minutes;                  // Duration(minutes: 30)
45.seconds;                  // Duration(seconds: 45)
```
</details>

<details>
<summary><b>Random Generation</b></summary>

```dart
10.randomLess();             // Random int < 10
5.randomMore(20);            // Random int between 5 and 20
```
</details>

<details>
<summary><b>Iteration</b></summary>

```dart
3.times(() => print('Hello'));              // Prints 'Hello' 3 times
3.timesIndexed((i) => print('Index: $i'));  // Prints indices 0, 1, 2
```
</details>

---

### DateTime Extensions

<details>
<summary><b>Time of Day Checks</b></summary>

```dart
final now = DateTime.now();
now.isMorning;               // Before 12 PM
now.isAfternoon;             // 12 PM - 6 PM
now.isEvening;               // 6 PM - 12 AM
now.isNight;                 // 12 AM - 6 AM
```
</details>

<details>
<summary><b>Date Checks</b></summary>

```dart
now.isToday;                 // true
now.isTomorrow;              // false
now.isYesterday;             // false
now.isInPast;                // false
now.isInFuture;              // false
now.isSameDay(DateTime(2025, 1, 15));  // Compare dates
```
</details>

<details>
<summary><b>Date Manipulation</b></summary>

```dart
now.addDays(5);
now.addMonths(2);
now.addYears(1);
now.addHours(3);
now.subDays(2);
now.startOfDay();            // Midnight of the same day
```
</details>

<details>
<summary><b>Age Calculations</b></summary>

```dart
DateTime(1990, 1, 1).toAge();              // Age in years
DateTime(1990, 1, 1).isAgeOlder(30);       // true
DateTime(2010, 1, 1).isAgeYounger(18);     // true
DateTime(2000, 1, 1).isAgeBetween(20, 30); // true
```
</details>

<details>
<summary><b>Formatting</b></summary>

```dart
now.format(MayrDateTimeFormats.usDate);    // '2025-01-15'
now.format(MayrDateTimeFormats.ukDate);    // '15/01/2025'
now.toTimeString();                        // '14:30:00'
now.toShortDate();                         // 'Wed 15th Jan'
now.toDayOrdinal();                        // '15th'
now.toTimeAgoString();                     // '2 hours ago'
now.humanize();                            // 'just now'
```
</details>

---

### Duration Extensions

<details>
<summary><b>Duration Operations</b></summary>

```dart
final duration = Duration(hours: 2, minutes: 30);

duration.toReadableString();               // '2h 30m'
duration.humanize();                       // '2 hours, 30 minutes'

duration.isLongerThan(Duration(hours: 1));   // true
duration.isShorterThan(Duration(hours: 5));  // true

// Delay execution
await 2.seconds.delay();
await 2.seconds.delay(() => print('Done!'));
```
</details>

---

### Bool Extensions

<details>
<summary><b>Boolean Operations</b></summary>

```dart
true.choose('Yes', 'No');                  // 'Yes'
false.choose('Yes', 'No');                 // 'No'
true.toInt();                              // 1
false.toInt();                             // 0
true.toYesNo();                            // 'Yes'
false.toYesNo(trueString: 'On', falseString: 'Off');  // 'Off'
true.not;                                  // false
```
</details>

---

### Function Extensions

<details>
<summary><b>Function Composition & Utilities</b></summary>

```dart
// Compose functions
final addOne = (int x) => x + 1;
final double = (int x) => x * 2;
final addOneThenDouble = double.compose(addOne);
addOneThenDouble(5);                       // 12

// Memoize (cache results)
final expensive = (int x) => x * x;
final memoized = expensive.memoize();

// Debounce
final search = (String query) => print('Searching: $query');
final debouncedSearch = search.debounce(Duration(milliseconds: 300));

// Throttle
final update = (String data) => print('Updating: $data');
final throttledUpdate = update.throttle(Duration(seconds: 1));

// Delayed execution
await greet.delayed(Duration(seconds: 1), 'John');
```
</details>

---

### Future Extensions

<details>
<summary><b>Async Operations</b></summary>

```dart
// Timeout with fallback
await fetchData().timeout(
  Duration(seconds: 5),
  onTimeout: () => defaultValue,
);

// Retry on error
await fetchData().retryWhen(
  (error) => error is NetworkException,
  maxAttempts: 3,
);

// Catch errors
final result = await fetchData().catchError((error) => defaultValue);

// Map result
final length = await fetchString().thenMap((s) => s.length);

// Delay result
await fetchData().delay(Duration(seconds: 1));

// Track loading state
final loading = ValueNotifier(false);
await fetchData().withLoading(loading);
```
</details>

---

### Stream Extensions

<details>
<summary><b>Stream Operations</b></summary>

```dart
// Debounce stream
stream.debounceTime(Duration(milliseconds: 300));

// Throttle stream
stream.throttleTime(Duration(seconds: 1));

// Distinct values
stream.distinctUntilChanged();

// Buffer items
stream.bufferTime(Duration(seconds: 1));

// Retry on error
stream.retryWhen((error) => error is NetworkException);

// Find first matching
await stream.firstWhereOrNull((x) => x > 5);
```
</details>

---

### Uri Extensions

<details>
<summary><b>URL Manipulation</b></summary>

```dart
final uri = Uri.parse('https://api.example.com?key=value');

// Query parameters
uri.addQueryParam('newKey', 'newValue');
uri.removeQueryParam('key');
uri.hasQueryParam('key');                  // true
uri.getQueryParam('key');                  // 'value'
uri.replaceQueryParams({'new': 'params'});

// URL analysis
uri.isSecure;                              // true (https)
Uri.parse('https://api.example.com').domain;      // 'example.com'
Uri.parse('https://api.example.com').subdomain;   // 'api'
```
</details>

---

### Enum Extensions

<details>
<summary><b>Enum Utilities</b></summary>

```dart
enum Status { active, inProgress, completed }

// Display name
Status.inProgress.displayName;             // 'In Progress'

// JSON conversion
Status.active.toJson();                    // 'active'

// From string
Status.values.fromString('active');        // Status.active
```
</details>

---

### Range Extensions

<details>
<summary><b>Number Ranges</b></summary>

```dart
// Integer ranges
1.to(5);                                   // [1, 2, 3, 4, 5]
1.to(10, step: 2);                         // [1, 3, 5, 7, 9]
1.until(5);                                // [1, 2, 3, 4]
5.inRange(1, 10);                          // true

// Double ranges
1.0.to(3.0);                               // [1.0, 2.0, 3.0]
0.0.to(1.0, step: 0.25);                   // [0.0, 0.25, 0.5, 0.75, 1.0]
5.5.inRange(1.0, 10.0);                    // true
```
</details>

---

### List & Iterable Extensions

<details>
<summary><b>Safe Access</b></summary>

```dart
[1, 2, 3].firstOrNull();                   // 1
[].firstOrNull();                          // null
[1, 2, 3].lastOrNull();                    // 3
[1, 2, 3].getOrNull(5);                    // null
[1, 2, 3].getOrDefault(5, 0);              // 0
[1, 2, 3].singleWhereOrNull((e) => e == 2); // 2
```
</details>

<details>
<summary><b>Transformations</b></summary>

```dart
[1, 2, 3, 4, 5].chunked(2);                // [[1, 2], [3, 4], [5]]
['a', 'b'].mapIndexed((i, e) => '$i:$e');  // ['0:a', '1:b']
[1, null, 2].whereNotNull();               // [1, 2]
[[1, 2], [3]].flatten();                   // [1, 2, 3]
[1, 2, 3].flip();                          // [3, 2, 1]
```
</details>

<details>
<summary><b>Aggregations</b></summary>

```dart
[1, 2, 3, 4, 5].sumBy((e) => e);           // 15
[1, 2, 3, 4, 5].averageBy((e) => e);       // 3.0
[3, 1, 4, 1, 5].min();                     // 1
[3, 1, 4, 1, 5].max();                     // 5
[1, 2, 3, 4, 5].countWhere((e) => e > 3);  // 2
```
</details>

<details>
<summary><b>Mutations (Returns New List)</b></summary>

```dart
[1, 2, 3].insertIf(true, 4);               // [1, 2, 3, 4]
[1, 2, 2, 3].replaceWhere((e) => e == 2, 5); // [1, 5, 5, 3]
[1, 2, 3].append(4);                       // [1, 2, 3, 4]
[1, 2, 2, 3].unique();                     // [1, 2, 3]
```
</details>

---

### Map Extensions

```dart
final map = {'a': 1, 'b': 2};

map.getOrNull('c');                        // null
map.getOrDefault('c', 0);                  // 0
map.mapKeys((k, v) => k.toUpperCase());    // {'A': 1, 'B': 2}
map.mapValues((k, v) => v * 2);            // {'a': 2, 'b': 4}
map.invert();                              // {1: 'a', 2: 'b'}
map.merge({'b': 3, 'c': 4});               // {'a': 1, 'b': 3, 'c': 4}
{'name': 'John', 'age': '30'}.toQueryString(); // 'name=John&age=30'
```

---

### Set Extensions

```dart
{1, 2, 3}.toggle(2);                       // {1, 3}
{1, 2, 3}.toggle(4);                       // {1, 2, 3, 4}
{1, 2, 3}.intersects({2, 3, 4});           // true
{1, 2}.isSubsetOf({1, 2, 3});              // true
{1, 2}.unionAll([{2, 3}, {3, 4}]);         // {1, 2, 3, 4}
```

---

### Object Extensions

```dart
// let - Transform object inline
final result = 'hello'.let((it) => it.toUpperCase());  // 'HELLO'

// also - Execute side effects while maintaining value
final user = User('John')
  .also((it) => print('Created user: ${it.name}'))
  .also((it) => log.info('User logged'));
```

---

### Dynamic Extensions

```dart
// Debug mode helpers (pure Dart - no Flutter required)
final userId = getUserId().nullOnDebug<String>();      // null in debug
final debugInfo = getDebugInfo().onlyOnDebug<String>(); // value only in debug

// Random null simulation
final value = 'Simulate'.maybe(probability: 0.3);      // 30% chance of null

// Safe default value
String? name = null;
name.orDefault('Guest');                               // 'Guest'
```

---

## 🛠️ Tools

### MayrDateTimeFormats

Common date/time format patterns:

```dart
MayrDateTimeFormats.ukDate;        // 'dd/MM/yyyy'
MayrDateTimeFormats.ukDateTime;    // 'dd/MM/yyyy HH:mm:ss'
MayrDateTimeFormats.usDate;        // 'yyyy-MM-dd'
MayrDateTimeFormats.usDateTime;    // 'yyyy-MM-dd HH:mm:ss'
MayrDateTimeFormats.time;          // 'HH:mm:ss'
MayrDateTimeFormats.timeNoSecs;    // 'HH:mm'
```

---

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🏢 About MayR Labs

**mayr_dart_extensions** is maintained by [MayR Labs](https://mayrlabs.com).

- 🌐 Website: [https://mayrlabs.com](https://mayrlabs.com)
- 💻 GitHub: [https://github.com/MayR-Labs](https://github.com/MayR-Labs)
- 📦 More packages: Check out our other Dart and Flutter packages!

---

## 🌟 Support

If you find this package helpful:

- ⭐ Star the [repository](https://github.com/MayR-Labs/mayr_dart_extensions)
- 🐛 Report issues or suggest features
- 📢 Share with the community
- 🤝 Contribute improvements

---

## 📦 Related Packages

- **[mayr_flutter_extensions](https://pub.dev/packages/mayr_flutter_extensions)** - Flutter-specific extensions (BuildContext, Widget, etc.)

---

Made with ❤️ by MayR Labs
